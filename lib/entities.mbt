struct Entity {
  shape : Rect
  pos2d : Pos2D
  velocity2d : Velocity2D
  collide : Bool
  hitbox : Hitbox?
  hurtbox : Hurtbox?
  ori : Orientation
  anime : AnimeSet
  after : After?
  control : Control?
  mut live : Bool
  terrain : Terrain?
  team : Team
}

let player_entity : Entity = {
  shape: Rect::{ width: 12, height: 12 },
  pos2d: Pos2D::{ x: initial_pos.x, y: initial_pos.y },
  velocity2d: Velocity2D::{ x: 0, y: 0 },
  collide: true,
  hitbox: None,
  hurtbox: Some(Hurtbox::nonrigid(initial_max_armor, invince_time=40)),
  ori: Orientation::{ dir: Up, moving: false },
  anime: player_anime,
  after: Some(
    { after_event: fn() -> Unit { world.game_state.game_result = Lose } },
  ),
  control: Some(Control::player()),
  live: true,
  terrain: None,
  team: Player,
}

fn get_player() -> Entity {
  player_entity
}

fn norm_pos(x : Int, y : Int) -> Pos2D {
  { x: x.to_double() * 12, y: y.to_double() * 12 }
}

fn make_belt(x : Int, y : Int, dir : Direction8) -> Entity {
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: { x: 0, y: 0 },
    collide: false,
    hitbox: None,
    hurtbox: None,
    ori: Orientation::{ dir, moving: true },
    anime: belt_anime,
    after: None,
    control: None,
    live: true,
    terrain: Some(Belt),
    team: Other,
  }
}

fn make_river(x : Int, y : Int, width : Int, height : Int) -> Entity {
  Entity::{
    shape: Rect::{
      width: 12.0 * width.to_double(),
      height: 12.0 * height.to_double(),
    },
    pos2d: Pos2D::{ x: x.to_double() * 12, y: y.to_double() * 12 },
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: false,
    hitbox: None,
    hurtbox: None,
    ori: Orientation::new(),
    anime: river_anime(width, height),
    after: None,
    control: None,
    live: true,
    terrain: Some(Water),
    team: Other,
  }
}

fn make_forest(x : Int, y : Int, width : Int, height : Int) -> Entity {
  Entity::{
    shape: Rect::{
      width: 12.0 * width.to_double(),
      height: 12.0 * height.to_double(),
    },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: None,
    ori: Orientation::new(),
    anime: forest_anime(width, height),
    after: None,
    control: None,
    live: true,
    terrain: None,
    team: Other,
  }
}

fn make_mountain(x : Int, y : Int, width : Int, height : Int) -> Entity {
  Entity::{
    shape: Rect::{
      width: 12.0 * width.to_double(),
      height: 12.0 * height.to_double(),
    },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: Some(Hurtbox::Rigid),
    ori: Orientation::new(),
    anime: mountain_anime(width, height),
    after: None,
    control: None,
    live: true,
    terrain: None,
    team: Other,
  }
}

fn make_turret(x : Int, y : Int) -> Entity {
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: Some(Hurtbox::nonrigid(1)),
    ori: Orientation::new(),
    anime: turret_anime,
    after: None,
    control: Some(Control::enemy(Turret)),
    live: true,
    terrain: None,
    team: Enemy,
  }
}

fn make_superturret(x : Int, y : Int, after : After?) -> Entity {
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: Some(Hurtbox::nonrigid(3)),
    ori: Orientation::new(),
    anime: turret_anime,
    after,
    control: Some(Control::enemy(Superturret)),
    live: true,
    terrain: None,
    team: Enemy,
  }
}

fn make_jackal(x : Int, y : Int) -> Entity {
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: Some(Hurtbox::nonrigid(1)),
    ori: Orientation::new(),
    anime: jackal_anime,
    after: None,
    control: Some(Control::enemy(Jackal)),
    live: true,
    terrain: None,
    team: Enemy,
  }
}

fn make_rhino(x : Int, y : Int) -> Entity {
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: Some(Hurtbox::nonrigid(2)),
    ori: Orientation::new(),
    anime: rhino_anime,
    after: None,
    control: Some(Control::enemy(Rhino)),
    live: true,
    terrain: None,
    team: Enemy,
  }
}

fn make_eagle(x : Int, y : Int, after : After?) -> Entity {
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: false,
    hitbox: None,
    hurtbox: Some(Hurtbox::nonrigid(8)),
    ori: Orientation::new(),
    anime: eagle_anime,
    after,
    control: Some(Control::enemy(Eagle)),
    live: true,
    terrain: None,
    team: Enemy,
  }
}

fn make_turtle(x : Int, y : Int, after : After?) -> Entity {
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: Some(Hurtbox::nonrigid(14)),
    ori: Orientation::new(),
    anime: turtle_anime,
    after,
    control: Some(Control::enemy(Turtle)),
    live: true,
    terrain: None,
    team: Enemy,
  }
}

fn make_cobra(x : Int, y : Int, after : After?) -> Entity {
  {
    shape: Rect::{ width: 72, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: Some(Hurtbox::nonrigid(16)),
    ori: Orientation::new(),
    anime: cobra_anime,
    after,
    control: Some(Control::enemy(Cobra)),
    live: true,
    terrain: None,
    team: Enemy,
  }
}

fn make_spider(x : Int, y : Int, after : After?) -> Entity {
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: Some(Hurtbox::nonrigid(6)),
    ori: Orientation::new(),
    anime: spider_anime,
    after,
    control: Some(Control::enemy(Spider)),
    live: true,
    terrain: None,
    team: Enemy,
  }
}

fn make_gate(x : Int, y : Int, dir : Direction8) -> Entity {
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: Some(Rigid),
    ori: Orientation::new(dir~),
    anime: gate_anime,
    after: None,
    control: None,
    live: true,
    terrain: None,
    team: Enemy,
  }
}

fn make_netgate(x : Int, y : Int, dir : Direction8) -> Entity {
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: true,
    hitbox: None,
    hurtbox: Some(Hurtbox::Rigid),
    ori: Orientation::{ dir, moving: false },
    anime: netgate_anime,
    after: None,
    control: Some(Control::enemy(Netgate)),
    live: true,
    terrain: None,
    team: Enemy,
  }
}

fn make_heal(x : Int, y : Int) -> Entity {
  let heal_event = fn() -> Unit {
    let player = get_player()
    world.game_state.player_max_armor += 1
    match player.hurtbox.unwrap() {
      Rigid => @w4x.w4panic("player's hurtbox is rigid")
      Nonrigid(_) as n => n.health = world.game_state.player_max_armor
    }
    obtain_sound()
  }
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: false,
    hitbox: None,
    hurtbox: None,
    ori: Orientation::new(),
    anime: heal_anime,
    after: Some({ after_event: heal_event }),
    control: None,
    live: true,
    terrain: Some(Bonus),
    team: Other,
  }
}

fn make_dashitem(x : Int, y : Int) -> Entity {
  let got_dash_event = fn() -> Unit {
    world.game_state.player_got_blink = true
    obtain_sound()
  }
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: false,
    hitbox: None,
    hurtbox: None,
    ori: Orientation::new(),
    anime: dash_anime,
    after: Some({ after_event: got_dash_event }),
    control: None,
    live: true,
    terrain: Some(Bonus),
    team: Other,
  }
}

fn make_wheel(x : Int, y : Int) -> Entity {
  let event = fn() -> Unit {
    world.game_state.player_speed += 0.4
    obtain_sound()
  }
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: false,
    hitbox: None,
    hurtbox: None,
    ori: Orientation::new(),
    anime: wheel_anime,
    after: Some({ after_event: event }),
    control: None,
    live: true,
    terrain: Some(Bonus),
    team: Other,
  }
}

fn make_missile(x : Int, y : Int) -> Entity {
  let event = fn() -> Unit {
    world.game_state.player_bullet_anime = missilebullet_anime
    world.game_state.player_bullet_damage = 2
    world.game_state.player_bullet_traj = 4.0
    world.game_state.player_bullet_duration = 20
    obtain_sound()
  }
  {
    shape: Rect::{ width: 12, height: 12 },
    pos2d: norm_pos(x, y),
    velocity2d: Velocity2D::{ x: 0, y: 0 },
    collide: false,
    hitbox: None,
    hurtbox: None,
    ori: Orientation::new(),
    anime: missileitem_anime,
    after: Some({ after_event: event }),
    control: None,
    live: true,
    terrain: Some(Bonus),
    team: Other,
  }
}
