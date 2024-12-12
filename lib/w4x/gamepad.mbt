pub(all) struct GamePad {
  button_1 : Bool
  button_2 : Bool
  button_left : Bool
  button_right : Bool
  button_up : Bool
  button_down : Bool
}

let address_GAMEPADS = 0x16

pub fn get_gamepad(index~ : UInt = 1) -> GamePad {
  if index.reinterpret_as_int() > 4 {
    @wasm4.trace("Gamepad index out of range")
    panic()
  }
  let state = load_byte(address_GAMEPADS + index.reinterpret_as_int() - 1).to_int()
  GamePad::{
    button_1: (state & 1) == 1,
    button_2: (state & 2) == 2,
    button_left: (state & 16) == 16,
    button_right: (state & 32) == 32,
    button_up: (state & 64) == 64,
    button_down: (state & 128) == 128,
  }
}

pub(all) struct PressedPad {
  index : UInt
  mut previous : GamePad
}

pub fn PressedPad::new(index~ : UInt = 1) -> PressedPad {
  { index, previous: get_gamepad(index~) }
}

pub fn PressedPad::get_pressed_buttons(self : PressedPad) -> GamePad {
  let pad = get_gamepad(index=self.index)
  let pressed = {
    button_1: pad.button_1 && not(self.previous.button_1),
    button_2: pad.button_2 && not(self.previous.button_2),
    button_left: pad.button_left && not(self.previous.button_left),
    button_right: pad.button_right && not(self.previous.button_right),
    button_up: pad.button_up && not(self.previous.button_up),
    button_down: pad.button_down && not(self.previous.button_down),
  }
  self.previous = pad
  pressed
}

pub fn pad_vertical(index~ : UInt = 1) -> Double {
  let pad = get_gamepad(index~)
  if pad.button_right && not(pad.button_left) {
    1
  } else if pad.button_left && not(pad.button_right) {
    -1
  } else {
    0
  }
}

pub fn pad_horizontal(index~ : UInt = 1) -> Double {
  let pad = get_gamepad(index~)
  if pad.button_down && not(pad.button_up) {
    1
  } else if pad.button_up && not(pad.button_down) {
    -1
  } else {
    0
  }
}
