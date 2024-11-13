enum Ai {
  Rhino // Regular enemy
  Jackal // Regular enemy
  Turret // Forest boss
  Turtle // Pier boss 1
  Eagle // Pier boss 2
  Cobra // Cave boss 
  Spider // Factory boss 
  // Hyena // Paradise boss
  Netgate // net gate
  Superturret // Factory boss
}

struct ActionSet {
  actions : Array[Action]
  period : Int
}

enum Action {
  Once(Command, Int)
  Last(Command, Int, Int)
}

fn get_action_set(ai : Ai) -> ActionSet {
  match ai {
    Rhino =>
      ActionSet::{
        actions: [
          Once(OrientPlayer, 0),
          Last(MoveForward(0.6), 0, 60),
          Once(Stand, 60),
          Once(OrientPlayer, 60),
          Once(ShootForward(40, 0.6, 1), 70),
        ],
        period: 120,
      }
    Turret =>
      {
        actions: [
          Once(OrientPlayer, 0),
          Once(ShootForward(60, 0.8, 1), 10),
          Once(OrientPlayer, 20),
          Once(ShootForward(60, 0.8, 1), 30),
          Once(OrientPlayer, 40),
          Once(ShootForward(60, 0.8, 1), 50),
        ],
        period: 100,
      }
    Superturret =>
      {
        actions: [
          Once(OrientPlayer, 0),
          Once(ShootForward(60, 1.0, 1), 10),
          Once(OrientPlayer, 20),
          Once(ShootForward(60, 1.0, 1), 30),
          Once(OrientPlayer, 40),
          Once(ShootForward(60, 1.0, 1), 50),
          Once(OrientPlayer, 60),
          Once(ShootForward(60, 1.0, 1), 70),
        ],
        period: 120,
      }
    Jackal =>
      {
        actions: [
          Once(OrientPlayer, 0),
          Once(ShootForward(40, 1.0, 1), 5),
          Last(Stand, 0, 15),
          Once(OrientRandom, 15),
          Last(MoveForward(1.2), 15, 60),
        ],
        period: 60,
      }
    Eagle =>
      {
        actions: [
          Once(Orient(Right), 0),
          Once(Orient(Down), 90),
          Once(Orient(Left), 180),
          Once(Orient(Up), 270),
          Last(MoveForward(1.0), 0, 360),
          Once(ShootPlayer(40, 1.2, 1), 45),
          Once(ShootPlayer(40, 1.2, 1), 135),
          Once(ShootPlayer(40, 1.2, 1), 225),
          Once(ShootPlayer(40, 1.2, 1), 315),
        ],
        period: 360,
      }
    Turtle =>
      {
        actions: [
          Once(Orient(DownLeft), 0),
          Once(Orient(UpLeft), 60),
          Once(Orient(UpRight), 120),
          Once(Orient(DownRight), 180),
          Last(MoveForward(0.6), 0, 240),
          Once(ShootPlayer(40, 1.2, 1), 20),
          Once(ShootPlayer(40, 1.2, 1), 80),
          Once(ShootPlayer(40, 1.2, 1), 140),
          Once(ShootPlayer(40, 1.2, 1), 200),
        ],
        period: 240,
      }
    Cobra =>
      {
        actions: [
          Once(CobraShoot(0), 0),
          Once(CobraShoot(1), 20),
          Once(CobraShoot(2), 40),
          Once(CobraShoot(3), 60),
          Once(CobraShoot(4), 80),
          Once(CobraShoot(5), 100),
          Once(CobraShoot(5), 180),
          Once(CobraShoot(4), 200),
          Once(CobraShoot(3), 220),
          Once(CobraShoot(2), 240),
          Once(CobraShoot(1), 260),
          Once(CobraShoot(0), 280),
        ],
        period: 360,
      }
    Spider =>
      {
        actions: [
          Once(Scream, 0),
          Once(OrientRandom, 30),
          Once(OrientRandom, 90),
          Once(OrientRandom, 120),
          Once(OrientRandom, 180),
          Once(OrientRandom, 210),
          Once(OrientRandom, 300),
          Once(OrientRandom, 360),
          Once(OrientRandom, 390),
          Once(OrientRandom, 450),
          Once(OrientRandom, 480),
          Once(OrientRandom, 540),
          Last(MoveForward(0.9), 15, 255),
          Last(MoveForward(0.9), 295, 565),
          Once(ShootPlayer(30, 1.0, 1), 60),
          Once(ShootPlayer(30, 1.0, 1), 150),
          Once(ShootPlayer(30, 1.0, 1), 300),
          Once(ShootPlayer(30, 1.0, 1), 420),
          Once(ShootPlayer(30, 1.0, 1), 540),
        ],
        period: 600,
      }
    Netgate => { actions: [Last(Netshoot, 0, 60)], period: 120 }
  }
}

fn ai_control(
  ai : Ai,
  ori : Orientation,
  pos : Pos2D,
  v : Velocity2D,
  frame : Int
) -> Unit {
  let action_set = get_action_set(ai)
  let inner_frame = frame % action_set.period
  for action in action_set.actions {
    match action {
      Once(cmd, at) => if inner_frame == at { execute(cmd, ori, pos, v, Enemy) }
      Last(cmd, from, to) =>
        if inner_frame >= from && inner_frame < to {
          execute(cmd, ori, pos, v, Enemy)
        }
    }
  }
}
