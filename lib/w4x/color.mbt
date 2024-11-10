let address_DRAW_COLORS = 0x14

pub fn set_draw_colors(colors : Int) -> Unit {
  store_i16(address_DRAW_COLORS, colors)
}

pub fn set_palette(
  color1 : UInt,
  color2 : UInt,
  color3 : UInt,
  color4 : UInt
) -> Unit {
  @wasm4.set_palette(1, color1 |> @wasm4.rgb)
  @wasm4.set_palette(2, color2 |> @wasm4.rgb)
  @wasm4.set_palette(3, color3 |> @wasm4.rgb)
  @wasm4.set_palette(4, color4 |> @wasm4.rgb)
}