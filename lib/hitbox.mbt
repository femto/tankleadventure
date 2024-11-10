struct Hitbox {
  mut damage : Int
}

enum Team {
  Player 
  Enemy 
  Other
} derive(Eq, Show)

enum Hurtbox {
  Rigid
  Nonrigid(mut ~health : Int, mut ~invincible : Bool, ~invince_time : Int)
}

fn Hurtbox::nonrigid(health : Int, ~invince_time : Int = 1) -> Hurtbox {
  Nonrigid(~health, invincible=false, ~invince_time)
}

fn hit_system(entities : Array[Entity]) -> Unit {
  let hits = entities.filter(fn(e) { not(e.hitbox.is_empty()) })
  let hurts = entities.filter(fn(e) { not(e.hurtbox.is_empty()) })
  for hit in hits {
    for hurt in hurts {
      if hit.live && hurt.live {
        let hit_collision = hit.shape.into_collision(hit.pos2d)
        let hurt_collision = hurt.shape.into_collision(hurt.pos2d)
        if hit_collision.collide(hurt_collision) && hit.team != hurt.team {
          match hurt.hurtbox.unwrap() {
            Nonrigid(_) as nr => {
              if nr.invincible {
                continue
              }
              nr.health -= hit.hitbox.unwrap().damage
              nr.invincible = true
              world.add_timer(
                {
                  rest: nr.invince_time,
                  effect: fn() { nr.invincible = false },
                },
              )
              if nr.health <= 0 {
                explode_sound()
                hurt.live = false
              }
              hit.live = false
            }
            _ => hit.live = false
          }
        }
      }
    }
  }
}
