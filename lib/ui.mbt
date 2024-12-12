fn ui_system(_entities : Array[Entity]) -> Unit {
  player_life()
  show_game_result()
}

fn player_life() -> Unit {
  let armor_max = world.game_state.player_max_armor
  let player = get_player()
  player.hurtbox.map(
    fn(hurtbox) {
      match hurtbox {
        Hurtbox::Nonrigid(health~, invince_time=_, invincible=_) => {
          let length = armor_max * 8 + 4
          @w4x.set_draw_colors(0x0033)
          @wasm4.rect(6, 3, length, 10)
          let length = (armor_max - health) * 8
          if length > 0 {
            @w4x.set_draw_colors(0x0022)
            @wasm4.rect(8 + health * 8, 5, length, 6)
          }
        }
        _ => @w4x.w4panic("player armor is rigid")
      }
    },
  )
  |> ignore
}

fn show_game_result() -> Unit {
  match world.game_state.game_result {
    Win => {
      @w4x.set_draw_colors(0x3)
      @wasm4.text("VICTORY!", 12, 50)
      @wasm4.text("THANK YOU FOR ", 12, 62)
      @wasm4.text("  PLAYING MY GAME!", 12, 74)
      @wasm4.text("TANKLE ADVENTURE", 12, 86)
      @wasm4.text("  MADE IN MOONBIT", 12, 98)
      @wasm4.text("  BY MILKY NATAS", 12, 110)
      @wasm4.text("  2024", 12, 122)
    }
    Lose => {
      @w4x.set_draw_colors(0x3)
      @wasm4.text("DEFEATED!", 12, 50)
      @wasm4.text("PRESS R TO RETRY!", 12, 62)
    }
    Running => ignore(0)
  }
}
