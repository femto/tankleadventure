fn set_great_palette() -> Unit {
  @w4x.set_palette(0xe9efec, 0xa0a08b, 0x555568, 0x211e20)
}

pub fn start() -> Unit {
  set_great_palette()
  world
  // systems
  ..add_system(life_system)
  ..add_system(render_system)
  ..add_system(ui_system)
  ..add_system(holdcamera_system)
  ..add_system(move_system)
  ..add_system(control_system)
  ..add_system(hit_system)
  ..add_system(timer_system)
  ..add_system(terrain_system)
  // levels
  ..add_entities(level_forest_environment())
  ..add_entities(level_pier_environment())
  ..add_entities(level_cave_environment())
  ..add_entity(player_entity)
  ..add_entities(level_forest_enemies())
  ..add_entities(level_pier_enemies())
  ..add_entities(level_cave_enemies())
  |> ignore()
}

pub fn update() -> Unit {
  world.update_frame()
}
