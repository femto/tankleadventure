pub fn draw_rect(
  x : Double,
  y : Double,
  width : Double,
  height : Double
) -> Unit {
  @wasm4.rect(x.to_int(), y.to_int(), width.to_int(), height.to_int())
}

pub fn draw_oval(
  x : Double,
  y : Double,
  width : Double,
  height : Double
) -> Unit {
  @wasm4.oval(x.to_int(), y.to_int(), width.to_int(), height.to_int())
}

pub fn blit2BPP(
  image : Bytes,
  x : Double,
  y : Double,
  width : Int,
  height : Int,
  flip_x : Bool,
  flip_y : Bool,
  rotate : Bool
) -> Unit {
  let blit_flag : @wasm4.BlitFlag = {
    one_bit_per_pixel: false,
    flip_x,
    flip_y,
    rotate,
  }
  @wasm4.blit(
    @wasm4.sprite(image),
    x.to_int(),
    y.to_int(),
    width,
    height,
    blit_flag,
  )
}

pub fn blitsub2BPP(
  image : Bytes,
  x : Double,
  y : Double,
  src_x : Int,
  src_y : Int,
  width : Int,
  height : Int,
  stride : Int,
  flip_x : Bool,
  flip_y : Bool,
  rotate : Bool
) -> Unit {
  let blit_flag : @wasm4.BlitFlag = {
    one_bit_per_pixel: false,
    flip_x,
    flip_y,
    rotate,
  }
  @wasm4.blit_sub(
    @wasm4.sprite(image),
    x.to_int(),
    y.to_int(),
    width,
    height,
    src_x,
    src_y,
    stride,
    blit_flag,
  )
}
