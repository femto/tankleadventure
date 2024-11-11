fn shoot_sound() -> Unit {
  @wasm4.tone(
    (860, 150),
    @wasm4.ADSR::new(0, release=0, decay=6, attack=5),
    @wasm4.ADSRVolume::new(100),
    @wasm4.ToneFlag::new(
      channel=@wasm4.ToneChannel::Pulse1,
      mode=@wasm4.ToneMode::Duty_1_8,
    ),
  )
}

fn explode_sound() -> Unit {
  @wasm4.tone(
    (200, 500),
    @wasm4.ADSR::new(10, attack=10, decay=30, release=5),
    @wasm4.ADSRVolume::new(80),
    @wasm4.ToneFlag::new(channel=@wasm4.ToneChannel::Noise),
  )
}

fn scream_sound() -> Unit {
  @wasm4.tone(
    (900, 900),
    @wasm4.ADSR::new(50, attack=5, decay=15, release=10),
    @wasm4.ADSRVolume::new(120),
    @wasm4.ToneFlag::new(channel=@wasm4.ToneChannel::Noise),
  )
}

fn obtain_sound() -> Unit {
  @wasm4.tone(
    (200, 600),
    @wasm4.ADSR::new(20, attack=0, decay=20, release=5),
    @wasm4.ADSRVolume::new(80),
    @wasm4.ToneFlag::new(
      channel=@wasm4.ToneChannel::Pulse1,
      mode=@wasm4.ToneMode::Duty_1_2,
    ),
  )
}
