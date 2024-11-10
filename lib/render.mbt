fn render_system(entities : Array[Entity]) -> Unit {
  for e in entities {
    e.anime.draw(e.pos2d, e.ori)
  }
}
