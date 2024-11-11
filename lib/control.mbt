enum Control {
  Player(@w4x.PressedPad, mut ~shoot_cd : Int, mut ~blink_cd : Int)
  Enemy(Ai, mut ~frame_counter : Int)
}

fn Control::player() -> Control {
  Player(@w4x.PressedPad::new(), shoot_cd=0, blink_cd=0)
}

fn Control::enemy(ai : Ai) -> Control {
  Enemy(ai, frame_counter=0)
}

let player_blink_cd = 60

let blink_maintain = 10

let blink_acc = 4.0

fn control_system(entities : Array[Entity]) -> Unit {
  let game_state = world.game_state
  for e in entities {
    e.control.map(
      fn(ctrl) {
        let v = e.velocity2d
        let ori = e.ori
        let pos = e.pos2d
        match ctrl {
          Player(pad, ~shoot_cd, ~blink_cd) as pctrl => {
            let pressed = pad.get_pressed_buttons()
            // moving
            if blink_cd <= player_blink_cd - blink_maintain {
              // blinking
              if pressed.button_1 &&
                game_state.player_got_blink &&
                blink_cd == 0 {
                let vel = ori.dir.to_velocity()
                v.x = vel.x * blink_acc
                v.y = vel.y * blink_acc
                pctrl.blink_cd = player_blink_cd
              } else {
                v.x = @w4x.pad_vertical() * game_state.player_speed
                v.y = @w4x.pad_horizontal() * game_state.player_speed
                if v.x != 0 {
                  v.y *= 0.7
                }
                if v.y != 0 {
                  v.x *= 0.7
                }
              }
              if v.x != 0 || v.y != 0 {
                let dir = Direction8::from_velocity(v)
                ori.dir = dir
                ori.moving = true
              } else {
                ori.moving = false
              }
            } else {
              let vel = ori.dir.to_velocity()
              v.x = vel.x * blink_acc
              v.y = vel.y * blink_acc
            }
            if blink_cd > 0 {
              pctrl.blink_cd -= 1
            }

            // shooting
            if shoot_cd > 0 {
              pctrl.shoot_cd -= 1
            } else if pressed.button_2 {
              shoot(
                pos,
                Bullet::{
                  dir: ori.dir,
                  duration: game_state.player_bullet_duration,
                  traj: game_state.player_bullet_traj,
                  damage: game_state.player_bullet_damage,
                  anime: game_state.player_bullet_anime,
                },
                Player,
              )
              shoot_sound()
              pctrl.shoot_cd = game_state.player_cd
            }
          }
          Enemy(ai, ~frame_counter) as enemy => {
            let collision = e.shape.into_collision(pos)
            let camera_fake_collision = {
              size: { width: 172, height: 172 },
              pos: { x: camera.pos.x, y: camera.pos.y },
            }
            if collision.collide(camera_fake_collision) {
              ai_control(ai, ori, pos, v, frame_counter)
              enemy.frame_counter = frame_counter + 1
            } else {
              // enemy.frame_counter = 0
              v.x = 0
              v.y = 0
              ori.moving = false
            }
          }
        }
      },
    )
    |> ignore()
  }
}
