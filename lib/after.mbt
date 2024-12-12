struct After {
  after_event : () -> Unit
}

fn After::op_shr(self : After, other : After) -> After {
  After::{
    after_event: fn() -> Unit {
      (self.after_event)()
      (other.after_event)()
    },
  }
}

fn make_unlock_event(pos : Pos2D, cond~ : () -> Bool = fn() { true }) -> After {
  let event = fn() -> Unit {
    if not(cond()) {
      return
    }
    let gate = find_gate(pos)
    gate.map(
      fn(g) {
        let unlockgate = {
          shape: Rect::{ width: 12, height: 12 },
          pos2d: g.pos2d,
          velocity2d: Velocity2D::{ x: 0, y: 0 },
          collide: true,
          hitbox: None,
          hurtbox: Some(nonrigid(1)),
          ori: g.ori,
          anime: unlockgate_anime,
          after: None,
          control: None,
          live: true,
          terrain: None,
          team: Enemy,
        }
        g.live = false
        world.add_entity(unlockgate)
      },
    )
    |> ignore()
  }
  After::{ after_event: event }
}

fn find_gate(pos : Pos2D) -> Entity? {
  for e in world.entities {
    if e.pos2d == pos {
      return Some(e)
    }
  }
  None
}

fn make_victory_event(cond : () -> Bool) -> After {
  After::{
    after_event: fn() -> Unit {
      if cond() {
        world.game_state.game_result = Win
      }
    },
  }
}
