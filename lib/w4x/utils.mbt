pub fn w4panic[T](msg : String) -> T {
  @wasm4.trace(msg)
  panic()
}

pub fn w4expect[T](opt : T?, msg : String) -> T {
  match opt {
    Some(v) => v
    None => w4panic(msg)
  }
}
