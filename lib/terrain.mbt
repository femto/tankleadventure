enum Terrain {
  Water
  Belt
  Bonus
}

fn terrain_system(entities : Array[Entity]) -> Unit {
  for e in entities {
    for t in entities {
      if e.collide && not(t.terrain.is_empty()) {
        let e_collision = e.shape.into_collision(e.pos2d)
        let t_collision = t.shape.into_collision(t.pos2d)
        if e_collision.collide(t_collision) {
          match t.terrain.unwrap() {
            Water => {
              e.velocity2d.x *= 0.5
              e.velocity2d.y *= 0.5
            }
            Belt => {
              let v = t.ori.dir.to_velocity()
              e.velocity2d.x += v.x * 0.9
              e.velocity2d.y += v.y * 0.9
              e.ori.moving = true
            }
            Bonus => if e.team == Player { t.live = false }
          }
          break
        }
      }
    }
  }
}
