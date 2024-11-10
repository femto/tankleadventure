extern "wasm" fn load_byte(offset : Int) -> Byte =
  #|(func (param i32) (result i32) (i32.load8_u (local.get 0)))

extern "wasm" fn store_i16(offset : Int, value : Int) =
  #|(func (param i32) (param i32) (i32.store16 (local.get 0) (local.get 1)))
