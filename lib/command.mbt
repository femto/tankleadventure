enum Command {
  Stand
  ShootForward(Int, Double, Int)
  MoveForward(Double)
  ShootPlayer(Int, Double, Int)
  OrientPlayer
  OrientRandom
  Orient(Direction8)
  CobraShoot(Int)
  Scream
  Netshoot
}

fn execute(
  cmd : Command,
  ori : Orientation,
  pos : Pos2D,
  v : Velocity2D,
  team : Team
) -> Unit {
  match cmd {
    Stand => {
      ori.moving = false
      v.x = 0
      v.y = 0
    }
    ShootForward(duration, traj, damage) =>
      shoot(
        pos,
        { dir: ori.dir, duration, traj, damage, anime: hollowbullet_anime },
        team,
      )
    MoveForward(speed) => {
      let vel = ori.dir.to_velocity()
      v.x = vel.x * speed
      v.y = vel.y * speed
      ori.moving = true
    }
    OrientPlayer => {
      let player_pos = get_player().pos2d
      let dir = Direction8::from_velocity(
        Velocity2D::{ x: player_pos.x - pos.x, y: player_pos.y - pos.y },
      )
      ori.dir = dir
    }
    Orient(dir) => ori.dir = dir
    OrientRandom => {
      let dir = Direction8::random()
      ori.dir = dir
    }
    ShootPlayer(duration, traj, damage) => {
      let player_pos = get_player().pos2d
      let dir = Direction8::from_velocity(
        Velocity2D::{ x: player_pos.x - pos.x, y: player_pos.y - pos.y },
      )
      shoot(
        pos,
        { dir, duration, traj, damage, anime: hollowbullet_anime },
        team,
      )
    }
    CobraShoot(offset) => {
      let bullet = {
        dir: Down,
        duration: 120,
        traj: 1.0,
        damage: 1,
        anime: hollowbullet_anime,
      }
      let pos_offset = Pos2D::{ x: pos.x + offset.to_double() * 12, y: pos.y }
      shoot(pos_offset, bullet, team)
    }
    Scream => {
      world.game_state.player_speed *= 0.5
      world.add_timer(
        { rest: 240, effect: fn() { world.game_state.player_speed *= 2 } },
      )
      scream_sound()
    }
    Netshoot =>
      shoot(
        pos,
        {
          dir: ori.dir,
          duration: 4,
          traj: 8.0,
          damage: 1,
          anime: netbullet_anime,
        },
        team,
      )
  }
}
