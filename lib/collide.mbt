struct Collision {
  size : Rect
  pos : Pos2D
}

fn Rect::into_collision(self : Rect, pos : Pos2D) -> Collision {
  { size: self, pos }
}

fn Collision::collide(a : Collision, b : Collision) -> Bool {
  a.pos.x < b.pos.x + b.size.width &&
  a.pos.x + a.size.width > b.pos.x &&
  a.pos.y < b.pos.y + b.size.height &&
  a.pos.y + a.size.height > b.pos.y
}

fn make_ray_collision(
  object : Collision,
  velocity : Velocity2D,
  axis : Int
) -> Collision {
  let pos : Pos2D = { x: object.pos.x, y: object.pos.y }
  let size : Rect = { width: object.size.width, height: object.size.height }
  if velocity[axis] >= 0 {
    size[axis] += velocity[axis]
  } else {
    pos[axis] += velocity[axis]
    size[axis] -= velocity[axis]
  }
  size.into_collision(pos)
}

test "make_ray_collision" {
  let object = Collision::{
    size: Rect::{ width: 10, height: 10 },
    pos: Pos2D::{ x: 0, y: 0 },
  }
  let velocity = Velocity2D::{ x: 5, y: 5 }
  let ray_collision = make_ray_collision(object, velocity, 0)
  assert_eq!(ray_collision.pos.x, 0)
  assert_eq!(ray_collision.pos.y, 0)
  assert_eq!(ray_collision.size.width, 15)
  assert_eq!(ray_collision.size.height, 10)
}

fn get_all_collisions(entities : Array[Entity]) -> Array[Collision] {
  entities.filter(fn (e) { e.collide }).map(
    fn (e) {
      let pos2d = e.pos2d
      let rect = e.shape
      rect.into_collision(pos2d)
    },
  )
}
