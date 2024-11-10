fn move_system(entities : Array[Entity]) -> Unit {
  let collisions = get_all_collisions(entities)
  for e in entities {
    if not(e.collide) {
      e.pos2d.x += e.velocity2d.x
      e.pos2d.y += e.velocity2d.y
    } else {
      let collision = e.shape.into_collision(e.pos2d)
      let other_collisions = collisions.filter(fn(c) { c.pos != collision.pos })
      let (pos, _c) = move_with_collide(collision, e.velocity2d, other_collisions)
      e.pos2d.x = pos.x
      e.pos2d.y = pos.y
    }
  }
}

fn move_with_collide(
  object : Collision,
  velocity : Velocity2D,
  collisions : Array[Collision]
) -> (Pos2D, Bool) {
  let (new_pos_x, collide_x) = move_axis(object, velocity, collisions, 0)
  let object_x = Collision::{ size: object.size, pos: new_pos_x }
  let (new_pos_y, collide_y) = move_axis(object_x, velocity, collisions, 1)
  (new_pos_y, collide_x || collide_y)
}

fn move_axis(
  object : Collision,
  velocity : Velocity2D,
  collisions : Array[Collision],
  axis : Int
) -> (Pos2D, Bool) {
  let new_pos = Pos2D::{ x: object.pos.x, y: object.pos.y }
  let velocity_axis : Velocity2D = { x: 0, y: 0 }
  velocity_axis[axis] = velocity[axis]
  let ray_collision = make_ray_collision(object, velocity_axis, axis)
  new_pos[axis] += velocity[axis]
  for collision in collisions {
    if ray_collision.collide(collision) {
      if velocity[axis] > 0 {
        new_pos[axis] = collision.pos[axis] - object.size[axis]
      } else if velocity[axis] < 0 {
        new_pos[axis] = collision.pos[axis] + collision.size[axis]
      }
      velocity[axis] = 0
      return (new_pos, true)
    }
  }
  return (new_pos, false)
}
