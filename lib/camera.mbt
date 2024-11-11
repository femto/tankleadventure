let camera : Camera = Camera::new()

struct Camera {
  pos : Pos2D
}

fn Camera::new() -> Camera {
  { pos: Pos2D::{ x: initial_pos.x - 80, y: initial_pos.y - 80 } }
}

fn set_camera(x : Double, y : Double) -> Unit {
  camera.pos.x = x
  camera.pos.y = y
}

let camera_anchors : Array[Pos2D] = [
  norm_pos(55, -47),
  norm_pos(70, -32),
  norm_pos(100, -34),
  norm_pos(99, -50),
]

let anchor_radius : Double = 72

fn holdcamera_system(_entities : Array[Entity]) -> Unit {
  let supposed = supposed_camera()
  let target = Velocity2D::{
    x: smooth_drag(camera.pos.x, supposed.x),
    y: smooth_drag(camera.pos.y, supposed.y),
  }
  set_camera(target.x, target.y)
}

fn smooth_drag(x : Double, y : Double) -> Double {
  let drag_max = 1.5
  let sub = y - x
  if sub > drag_max {
    return x + drag_max
  } else if sub < -drag_max {
    return x - drag_max
  } else {
    return y
  }
}

fn supposed_camera() -> Pos2D {
  let player = get_player()
  let player_pos = player.pos2d
  let player_ori = player.ori
  for anchor in camera_anchors {
    let player_collision = {
      size: { width: 0, height: 0 },
      pos: { x: player_pos.x, y: player_pos.y },
    }
    let anchor_collision = {
      size: { width: anchor_radius * 2, height: anchor_radius * 2 },
      pos: { x: anchor.x - anchor_radius, y: anchor.y - anchor_radius },
    }
    if player_collision.collide(anchor_collision) {
      return { x: anchor.x - 80, y: anchor.y - 80 }
    }
  }
  if player_ori.moving {
    let vel = player_ori.dir.to_velocity()
    return {
      x: player_pos.x - 74 + vel.x * 20,
      y: player_pos.y - 74 + vel.y * 20,
    }
  } else {
    return { x: camera.pos.x, y: camera.pos.y }
  }
}
