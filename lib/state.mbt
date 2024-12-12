struct GameState {
  mut player_speed : Double
  mut player_bullet_duration : Int
  mut player_bullet_damage : Int
  mut player_bullet_traj : Double
  mut player_bullet_anime : AnimeSet
  mut player_max_armor : Int
  player_cd : Int
  mut player_got_blink : Bool
  mut superturret1_live : Bool
  mut superturret2_live : Bool
  mut cobra_live : Bool
  mut spider_live : Bool
  mut eagle_live : Bool
  mut turtle_live : Bool
  mut game_result : GameResult
}

enum GameResult {
  Win
  Lose
  Running
}

let initial_max_armor : Int = 5

let initial_pos : Pos2D = norm_pos(8, -2)

fn GameState::default() -> GameState {
  {
    player_speed: 0.8,
    player_bullet_duration: 30,
    player_bullet_damage: 1,
    player_bullet_traj: 2.0,
    player_bullet_anime: solidbullet_anime,
    player_max_armor: initial_max_armor,
    player_cd: 45,
    player_got_blink: false,
    superturret1_live: true,
    superturret2_live: true,
    cobra_live: true,
    spider_live: true,
    eagle_live: true,
    turtle_live: true,
    game_result: Running,
  }
}
