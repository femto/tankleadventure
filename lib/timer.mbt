struct Timer {
  mut rest : Int
  effect : () -> Unit
}

fn timer_system(_entities : Array[Entity]) -> Unit {
  for timer in world.timers {
    timer.rest -= 1
    if timer.rest <= 0 {
      (timer.effect)()
    }
  }
  world.timers.retain(fn(timer) { timer.rest > 0 })
}
