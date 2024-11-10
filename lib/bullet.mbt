struct Bullet {
  damage : Int
  traj : Double
  duration : Int
  dir : Direction8
  anime : AnimeSet
}

fn shoot(shooter_pos : Pos2D, bullet : Bullet, shooter_team : Team) -> Unit {
  let vec = bullet.dir.to_velocity()
  let bullet_pos = Pos2D::{
    x: shooter_pos.x + 4.0 + 8.0 * vec.x,
    y: shooter_pos.y + 4.0 + 8.0 * vec.y,
  }
  let bullet_v = Velocity2D::{ x: vec.x * bullet.traj, y: vec.y * bullet.traj }
  make_bullet(bullet_pos, bullet_v, bullet, shooter_team)
}

fn make_bullet(
  bullet_pos : Pos2D,
  bullet_v : Velocity2D,
  bullet : Bullet,
  team : Team
) -> Unit {
  let bullet_entity = {
    shape: Rect::{ width: 4, height: 4 },
    pos2d: bullet_pos,
    velocity2d: bullet_v,
    collide: false,
    hitbox: Some(Hitbox::{ damage: bullet.damage }),
    hurtbox: None,
    ori: Orientation::{ dir: bullet.dir, moving: false },
    anime: bullet.anime,
    after: None,
    control: None,
    live: true,
    terrain: None,
    team,
  }
  world.add_entity(bullet_entity)
  world.add_timer(
    { rest: bullet.duration, effect: fn() { bullet_entity.live = false } },
  )
}
