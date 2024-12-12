struct Sprite {
  image : Bytes
  stride : Int
  src_x : Int
  src_y : Int
  width : Int
  height : Int
  colors : Int
}

fn Sprite::new(
  src_x~ : Int,
  src_y~ : Int,
  width~ : Int,
  height~ : Int,
  colors~ : Int = 0x4320
) -> Sprite {
  Sprite::{
    image: assets,
    stride: assets_stride,
    src_x,
    src_y,
    width,
    height,
    colors,
  }
}

fn Sprite::draw(
  sprite : Sprite,
  pos : Pos2D,
  dir : Direction4,
  onscreen~ : Bool = false
) -> Unit {
  let (flip_x, flip_y, rotate) = dir.to_flips()
  let pos = if onscreen {
    pos
  } else {
    { x: pos.x - camera.pos.x, y: pos.y - camera.pos.y }
  }
  @w4x.set_draw_colors(sprite.colors)
  @w4x.blitsub2BPP(
    sprite.image,
    pos.x,
    pos.y,
    sprite.src_x,
    sprite.src_y,
    sprite.width,
    sprite.height,
    sprite.stride,
    flip_x,
    flip_y,
    rotate,
  )
}
