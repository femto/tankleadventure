fn life_system(entities : Array[Entity]) -> Unit {
  entities
  .filter(fn(e) { not(e.live) })
  .each(fn(e) { e.after.map(fn(a) { (a.after_event)() }) |> ignore() })
  entities.retain(fn(e) { e.live })
}
