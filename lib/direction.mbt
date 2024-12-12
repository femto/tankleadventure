enum Direction4 {
  Up
  Down
  Left
  Right
} derive(Eq)

fn Direction4::to_flips(dir : Direction4) -> (Bool, Bool, Bool) {
  match dir {
    Up => (false, false, false)
    Right => (true, true, true)
    Left => (false, false, true)
    Down => (true, true, false)
  }
}

enum Direction8 {
  Up
  Down
  Left
  Right
  UpLeft
  UpRight
  DownLeft
  DownRight
} derive(Eq)

fn Direction8::from_velocity(v : Velocity2D) -> Direction8 {
  let x = v.x
  let y = v.y
  if x == 0 && y == 0 {
    @w4x.w4panic("Origin point has no direction")
  }
  let abs_x = x.abs()
  let abs_y = y.abs()
  if abs_x > abs_y * 2 {
    if x > 0 {
      Right
    } else {
      Left
    }
  } else if abs_y > abs_x * 2 {
    if y > 0 {
      Down
    } else {
      Up
    }
  } else if x > 0 && y > 0 {
    DownRight
  } else if x > 0 && y < 0 {
    UpRight
  } else if x < 0 && y > 0 {
    DownLeft
  } else {
    UpLeft
  }
}

fn Direction8::to_velocity(self : Direction8) -> Velocity2D {
  match self {
    Up => Velocity2D::{ x: 0, y: -1 }
    Down => Velocity2D::{ x: 0, y: 1 }
    Left => Velocity2D::{ x: -1, y: 0 }
    Right => Velocity2D::{ x: 1, y: 0 }
    UpLeft => Velocity2D::{ x: -0.7, y: -0.7 }
    UpRight => Velocity2D::{ x: 0.7, y: -0.7 }
    DownLeft => Velocity2D::{ x: -0.7, y: 0.7 }
    DownRight => Velocity2D::{ x: 0.7, y: 0.7 }
  }
}

fn Direction8::random() -> Direction8 {
  let rand = rand.uint(limit=8)
  match rand {
    0 => Up
    1 => Down
    2 => Left
    3 => Right
    4 => UpLeft
    5 => UpRight
    6 => DownLeft
    7 => DownRight
    _ => @w4x.w4panic("Invalid random direction")
  }
}

struct Orientation {
  mut moving : Bool
  mut dir : Direction8
}

fn Orientation::new(dir~ : Direction8 = Up) -> Orientation {
  Orientation::{ moving: false, dir }
}

fn Direction8::to_direction4(self : Direction8) -> (Direction4, Bool) {
  match self {
    Up => (Up, false)
    Down => (Down, false)
    Left => (Left, false)
    Right => (Right, false)
    UpLeft => (Up, true)
    UpRight => (Right, true)
    DownLeft => (Left, true)
    DownRight => (Down, true)
  }
}
