enum AnimeSet {
  Car8(~udlr : AnimeSequence, ~diag : AnimeSequence, mut ~frame_counter : Int)
  Static(Sprite)
  Rect(Sprite, Int, Int)
}

fn AnimeSet::draw(self : AnimeSet, pos : Pos2D, ori : Orientation) -> Unit {
  match self {
    Car8(_) as car => {
      if ori.moving {
        car.frame_counter += 1
      }
      let (dir4, diag) = ori.dir.to_direction4()
      let sequence = if diag { car.diag } else { car.udlr }
      let frame = sequence._[car.frame_counter % sequence._.length()]
      frame.draw(pos, dir4)
    }
    Static(sprite) => sprite.draw(pos, ori.dir.to_direction4().0)
    Rect(sprite, width, height) =>
      for i in 0..<width {
        for j in 0..<height {
          sprite.draw(
            {
              x: pos.x + (sprite.width * i).to_double(),
              y: pos.y + (sprite.height * j).to_double(),
            },
            Up,
          )
        }
      }
  }
}

type AnimeSequence Array[Sprite]

let player_anime : AnimeSet = Car8(
  udlr=AnimeSequence(
    [
      Sprite::new(src_x=0, src_y=0, width=12, height=12),
      Sprite::new(src_x=12, src_y=0, width=12, height=12),
    ],
  ),
  diag=AnimeSequence(
    [
      Sprite::new(src_x=0, src_y=12, width=12, height=12),
      Sprite::new(src_x=12, src_y=12, width=12, height=12),
    ],
  ),
  frame_counter=0,
)

let jackal_anime : AnimeSet = Car8(
  udlr=AnimeSequence(
    [
      Sprite::new(src_x=0, src_y=24, width=12, height=12),
      Sprite::new(src_x=12, src_y=24, width=12, height=12),
    ],
  ),
  diag=AnimeSequence(
    [
      Sprite::new(src_x=0, src_y=36, width=12, height=12),
      Sprite::new(src_x=12, src_y=36, width=12, height=12),
    ],
  ),
  frame_counter=0,
)

let rhino_anime : AnimeSet = Car8(
  udlr=AnimeSequence(
    [
      Sprite::new(src_x=0, src_y=48, width=12, height=12),
      Sprite::new(src_x=12, src_y=48, width=12, height=12),
    ],
  ),
  diag=AnimeSequence(
    [
      Sprite::new(src_x=0, src_y=60, width=12, height=12),
      Sprite::new(src_x=12, src_y=60, width=12, height=12),
    ],
  ),
  frame_counter=0,
)

let turret_anime : AnimeSet = Car8(
  udlr=AnimeSequence([Sprite::new(src_x=0, src_y=72, width=12, height=12)]),
  diag=AnimeSequence([Sprite::new(src_x=12, src_y=72, width=12, height=12)]),
  frame_counter=0,
)

let tree_sprite : Sprite = Sprite::new(src_x=24, src_y=0, width=12, height=12)

let hill_sprite : Sprite = Sprite::new(src_x=36, src_y=0, width=12, height=12)

let water_sprite : Sprite = Sprite::new(src_x=48, src_y=0, width=12, height=12)

fn forest_anime(width : Int, height : Int) -> AnimeSet {
  Rect(tree_sprite, width, height)
}

fn mountain_anime(width : Int, height : Int) -> AnimeSet {
  Rect(hill_sprite, width, height)
}

fn river_anime(width : Int, height : Int) -> AnimeSet {
  Rect(water_sprite, width, height)
}

let eagle_anime : AnimeSet = Car8(
  udlr=AnimeSequence(
    [
      Sprite::new(src_x=24, src_y=12, width=12, height=12),
      Sprite::new(src_x=36, src_y=12, width=12, height=12),
    ],
  ),
  diag=AnimeSequence(
    [
      Sprite::new(src_x=24, src_y=12, width=12, height=12),
      Sprite::new(src_x=36, src_y=12, width=12, height=12),
    ],
  ),
  frame_counter=0,
)

let turtle_sprite1 : Sprite = Sprite::new(
  src_x=24,
  src_y=24,
  width=12,
  height=12,
)

let turtle_sprite2 : Sprite = Sprite::new(
  src_x=36,
  src_y=24,
  width=12,
  height=12,
)

let turtle_anime : AnimeSet = Car8(
  udlr=[
    turtle_sprite1, turtle_sprite1, turtle_sprite1, turtle_sprite1, turtle_sprite2,
    turtle_sprite2, turtle_sprite2, turtle_sprite2,
  ],
  diag=[
    turtle_sprite1, turtle_sprite1, turtle_sprite1, turtle_sprite1, turtle_sprite2,
    turtle_sprite2, turtle_sprite2, turtle_sprite2,
  ],
  frame_counter=0,
)

let cobra_anime : AnimeSet = Static(
  Sprite::new(src_x=0, src_y=84, width=72, height=12),
)

let solidbullet_anime : AnimeSet = Static(
  Sprite::new(src_x=24, src_y=48, width=4, height=4),
)

let hollowbullet_anime : AnimeSet = Static(
  Sprite::new(src_x=28, src_y=48, width=4, height=4),
)

let netbullet_anime : AnimeSet = Static(
  Sprite::new(src_x=24, src_y=52, width=4, height=4),
)

let missilebullet_anime : AnimeSet = Static(
  Sprite::new(src_x=28, src_y=52, width=4, height=4),
)

let spider_anime : AnimeSet = Car8(
  udlr=[
    Sprite::new(src_x=24, src_y=36, width=12, height=12),
    Sprite::new(src_x=36, src_y=36, width=12, height=12),
  ],
  diag=[
    Sprite::new(src_x=24, src_y=36, width=12, height=12),
    Sprite::new(src_x=36, src_y=36, width=12, height=12),
  ],
  frame_counter=0,
)

let belt_anime : AnimeSet = Car8(
  udlr=[
    Sprite::new(src_x=36, src_y=60, width=12, height=12),
    Sprite::new(src_x=36, src_y=72, width=12, height=12),
    Sprite::new(src_x=24, src_y=72, width=12, height=12),
  ],
  diag=[
    Sprite::new(src_x=36, src_y=60, width=12, height=12),
    Sprite::new(src_x=36, src_y=72, width=12, height=12),
    Sprite::new(src_x=24, src_y=72, width=12, height=12),
  ],
  frame_counter=0,
)

let heal_anime : AnimeSet = Static(
  Sprite::new(src_x=48, src_y=12, width=12, height=12),
)

let dash_anime : AnimeSet = Static(
  Sprite::new(src_x=48, src_y=24, width=12, height=12),
)

let wheel_anime : AnimeSet = Static(
  Sprite::new(src_x=48, src_y=36, width=12, height=12),
)

let missileitem_anime : AnimeSet = Static(
  Sprite::new(src_x=48, src_y=48, width=12, height=12),
)

let gate_anime : AnimeSet = Static(
  Sprite::new(src_x=36, src_y=48, width=12, height=12),
)

let unlockgate_anime : AnimeSet = Static(
  Sprite::new(src_x=48, src_y=60, width=12, height=12),
)

let netgate_anime : AnimeSet = Static(
  Sprite::new(src_x=24, src_y=60, width=12, height=12),
)

