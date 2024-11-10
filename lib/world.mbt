type System (Array[Entity]) -> Unit

struct World {
  entities : Array[Entity]
  systems : Array[System]
  game_state : GameState
  timers : Array[Timer]
}

fn World::default() -> World {
  {
    entities: [],
    systems: [],
    game_state: GameState::default(),
    timers: [],
  }
}

let world : World = World::default()

fn World::add_system(self : World, system : (Array[Entity]) -> Unit) -> Unit {
  self.systems.push(System(system))
}

fn World::add_entity(self : World, entity : Entity) -> Unit {
  self.entities.push(entity)
}

fn World::add_entities(self : World, entities : Array[Entity]) -> Unit {
  self.entities.append(entities)
}

fn World::add_timer(self : World, timer : Timer) -> Unit {
  self.timers.push(timer)
}

fn World::update_frame(self : World) -> Unit {
  for system in self.systems {
    (system._)(self.entities)
  }
}