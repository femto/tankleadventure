struct Pos2D {
  mut x : Double
  mut y : Double
} derive(Eq)

fn Pos2D::op_get(self : Pos2D, key : Int) -> Double {
  if key == 0 {
    self.x
  } else if key == 1 {
    self.y
  } else {
    panic()
  }
}

fn Pos2D::op_set(self : Pos2D, key : Int, value : Double) -> Unit {
  if key == 0 {
    self.x = value
  } else if key == 1 {
    self.y = value
  } else {
    panic()
  }
}

struct Velocity2D {
  mut x : Double
  mut y : Double
} derive(Eq)

fn Velocity2D::op_get(self : Velocity2D, key : Int) -> Double {
  if key == 0 {
    self.x
  } else if key == 1 {
    self.y
  } else {
    panic()
  }
}

fn Velocity2D::op_set(self : Velocity2D, key : Int, value : Double) -> Unit {
  if key == 0 {
    self.x = value
  } else if key == 1 {
    self.y = value
  } else {
    panic()
  }
}

struct Rect {
  mut width : Double
  mut height : Double
}

fn Rect::op_get(self : Rect, key : Int) -> Double {
  if key == 0 {
    self.width
  } else if key == 1 {
    self.height
  } else {
    panic()
  }
}

fn Rect::op_set(self : Rect, key : Int, value : Double) -> Unit {
  if key == 0 {
    self.width = value
  } else if key == 1 {
    self.height = value
  } else {
    panic()
  }
}
