fn level_forest_environment() -> Array[Entity] {
  [
    make_forest(0, -50, 4, 50),
    make_forest(14, -40, 4, 40),
    make_forest(0, 0, 18, 4),
    make_forest(0, -54, 60, 4),
    make_forest(14, -44, 46, 4),
    make_river(4, -10, 4, 2),
    make_river(10, -10, 4, 2),
    make_river(40, -50, 2, 4),
    make_river(48, -50, 2, 4),
    make_river(56, -50, 2, 4),
    make_river(44, -48, 2, 4),
    make_river(52, -48, 2, 4),
    make_mountain(59, -50, 1, 1),
    make_mountain(59, -45, 1, 1),
  ]
}

fn level_forest_enemies() -> Array[Entity] {
  [
    make_turret(4, -14),
    make_rhino(8, -24),
    make_jackal(8, -36),
    make_jackal(10, -40),
    make_turret(4, -50),
    make_turret(13, -50),
    make_heal(18, -46),
    make_netgate(20, -50, Down),
    make_netgate(25, -50, Down),
    make_netgate(30, -50, Down),
    make_netgate(20, -45, Up),
    make_netgate(25, -45, Up),
    make_netgate(30, -45, Up),
    make_rhino(42, -50),
    make_rhino(50, -50),
    make_jackal(46, -45),
    make_jackal(54, -45),
    make_superturret(
      59,
      -49,
      Some(
        { after_event: fn() { world.game_state.superturret1_live = false } } >>
        make_unlock_event(
          norm_pos(59, -47),
          cond=fn() { not(world.game_state.superturret2_live) },
        ) >>
        make_unlock_event(
          norm_pos(59, -48),
          cond=fn() { not(world.game_state.superturret2_live) },
        ),
      ),
    ),
    make_superturret(
      59,
      -46,
      Some(
        { after_event: fn() { world.game_state.superturret2_live = false } } >>
        make_unlock_event(
          norm_pos(59, -47),
          cond=fn() { not(world.game_state.superturret1_live) },
        ) >>
        make_unlock_event(
          norm_pos(59, -48),
          cond=fn() { not(world.game_state.superturret1_live) },
        ),
      ),
    ),
    make_gate(59, -47, Right),
    make_gate(59, -48, Right),
  ]
}

fn level_pier_environment() -> Array[Entity] {
  [
    make_forest(60, -54, 26, 4),
    make_forest(86, -47, 6, 3),
    make_forest(89, -50, 6, 3),
    make_forest(86, -57, 9, 6),
    make_river(89, -51, 6, 1),
    make_mountain(95, -57, 12, 2),
    make_mountain(105, -55, 2, 12),
  ]
}

fn level_pier_enemies() -> Array[Entity] {
  [
    make_rhino(76, -48),
    make_heal(75, -49),
    make_superturret(86, -48, None),
    make_superturret(86, -51, None),
    make_superturret(92, -47, None),
    make_heal(92, -45),
    make_turtle(
      102,
      -50,
      Some(
        { after_event: fn() { world.game_state.turtle_live = false } } >>
        make_victory_event(fn() { not(world.game_state.eagle_live) }),
      ),
    ),
    make_eagle(
      95,
      -54,
      Some(
        { after_event: fn() { world.game_state.eagle_live = false } } >>
        make_victory_event(fn() { not(world.game_state.turtle_live) }),
      ),
    ),
  ]
}

fn level_cave_environment() -> Array[Entity] {
  [
    make_mountain(60, -44, 4, 20),
    make_mountain(76, -44, 4, 20),
    make_mountain(60, -24, 20, 4),
    make_mountain(64, -44, 4, 1),
    make_mountain(72, -44, 4, 1),
    make_mountain(83, -44, 12, 3),
    make_mountain(80, -38, 12, 3),
    make_mountain(95, -44, 3, 15),
    make_mountain(104, -44, 3, 18),
    make_mountain(83, -32, 12, 3),
    make_mountain(80, -26, 27, 3),
    make_mountain(98, -44, 2, 1),
    make_mountain(102, -44, 2, 1),
    make_forest(64, -38, 4, 1),
    make_forest(72, -38, 4, 1),
    make_forest(64, -27, 5, 1),
    make_forest(71, -27, 5, 1),
  ]
}

fn level_cave_enemies() -> Array[Entity] {
  [
    make_belt(68, -44, Down),
    make_belt(69, -44, Down),
    make_belt(70, -44, Down),
    make_belt(71, -44, Down),
    make_turret(64, -40),
    make_turret(75, -40),
    make_belt(68, -38, Down),
    make_belt(69, -38, Down),
    make_belt(70, -38, Down),
    make_belt(71, -38, Down),
    make_gate(70, -27, Up),
    make_gate(69, -27, Up),
    make_spider(
      70,
      -28,
      Some(
        { after_event: fn() { world.game_state.spider_live = false } } >>
        make_unlock_event(norm_pos(70, -27)) >>
        make_unlock_event(norm_pos(69, -27)),
      ),
    ),
    make_dashitem(64, -25),
    make_heal(75, -25),
    make_belt(80, -44, Up),
    make_belt(81, -44, Up),
    make_belt(82, -44, Up),
    make_heal(80, -39),
    make_netgate(84, -39, Up),
    make_netgate(87, -39, Up),
    make_netgate(90, -39, Up),
    make_belt(83, -41, Right),
    make_belt(84, -41, Right),
    make_belt(85, -41, Right),
    make_belt(86, -41, Right),
    make_belt(87, -41, Right),
    make_belt(88, -41, Right),
    make_belt(89, -41, Right),
    make_belt(90, -41, Right),
    make_belt(91, -41, Right),
    make_belt(83, -40, Right),
    make_belt(84, -40, Right),
    make_belt(85, -40, Right),
    make_belt(86, -40, Right),
    make_belt(87, -40, Right),
    make_belt(88, -40, Right),
    make_belt(89, -40, Right),
    make_belt(90, -40, Right),
    make_belt(91, -40, Right),
    make_wheel(94, -41),
    make_netgate(84, -33, Up),
    make_netgate(87, -33, Up),
    make_netgate(90, -33, Up),
    make_belt(83, -35, Right),
    make_belt(84, -35, Right),
    make_belt(85, -35, Right),
    make_belt(86, -35, Right),
    make_belt(87, -35, Right),
    make_belt(88, -35, Right),
    make_belt(89, -35, Right),
    make_belt(90, -35, Right),
    make_belt(91, -35, Right),
    make_belt(83, -34, Right),
    make_belt(84, -34, Right),
    make_belt(85, -34, Right),
    make_belt(86, -34, Right),
    make_belt(87, -34, Right),
    make_belt(88, -34, Right),
    make_belt(89, -34, Right),
    make_belt(90, -34, Right),
    make_belt(91, -34, Right),
    make_netgate(84, -27, Up),
    make_netgate(87, -27, Up),
    make_netgate(90, -27, Up),
    make_superturret(88, -27, None),
    make_missile(80, -27),
    make_cobra(
      98,
      -39,
      Some(
        { after_event: fn() { world.game_state.cobra_live = false } } >>
        make_unlock_event(norm_pos(100, -44)) >>
        make_unlock_event(norm_pos(101, -44)),
      ),
    ),
    make_gate(100, -44, Up),
    make_gate(101, -44, Up),
  ]
}
