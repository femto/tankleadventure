// fn query[A : Component](~live : Bool = true) -> Array[(Entity, A)] {
//   let results = []
//   let compmap = A::get_map(world.components)
//   for entity, component in compmap._ {
//     if entity._ < world.entities.length() && world.entities[entity._] == live {
//       results.push((entity, component))
//     }
//   }
//   return results
// }

// fn qwith[A, B : Component](
//   from : Array[(Entity, A)]
// ) -> Array[(Entity, (A, B))] {
//   let results = []
//   let compmap = B::get_map(world.components)
//   for tuple in from {
//     let (entity, a) = tuple
//     if compmap._.contains(entity) {
//       results.push((entity, (a, compmap._[entity].unwrap())))
//     }
//   }
//   results
// }

// fn qwith_option[A, B : Component](
//   from : Array[(Entity, A)]
// ) -> Array[(Entity, (A, B?))] {
//   let compmap = B::get_map(world.components)
//   from.map(
//     fn(tuple) {
//       let (entity, a) = tuple
//       (entity, (a, compmap._[entity]))
//     },
//   )
// }

// fn qflat1[A, B](from : Array[(Entity, (A, B))]) -> Array[(Entity, A, B)] {
//   from.map(
//     fn(tuple) {
//       let (entity, (a, b)) = tuple
//       (entity, a, b)
//     },
//   )
// }

// fn qflat2[A, B, C](
//   from : Array[(Entity, ((A, B), C))]
// ) -> Array[(Entity, A, B, C)] {
//   from.map(
//     fn(tuple) {
//       let (entity, ((a, b), c)) = tuple
//       (entity, a, b, c)
//     },
//   )
// }

// fn qflat3[A, B, C, D](
//   from : Array[(Entity, (((A, B), C), D))]
// ) -> Array[(Entity, A, B, C, D)] {
//   from.map(
//     fn(tuple) {
//       let (entity, (((a, b), c), d)) = tuple
//       (entity, a, b, c, d)
//     },
//   )
// }

// fn qflat4[A, B, C, D, E](
//   from : Array[(Entity, ((((A, B), C), D), E))]
// ) -> Array[(Entity, A, B, C, D, E)] {
//   from.map(
//     fn(tuple) {
//       let (entity, ((((a, b), c), d), e)) = tuple
//       (entity, a, b, c, d, e)
//     },
//   )
// }

// fn query_r[A : Component, B : Component](
//   ~live : Bool = true
// ) -> Array[(Entity, A, B)] {
//   query(~live) |> qwith() |> qflat1()
// }

// fn query_rr[A : Component, B : Component, C : Component](
//   ~live : Bool = true
// ) -> Array[(Entity, A, B, C)] {
//   query(~live) |> qwith() |> qwith() |> qflat2()
// }

// fn query_rrr[A : Component, B : Component, C : Component, D : Component](
//   ~live : Bool = true
// ) -> Array[(Entity, A, B, C, D)] {
//   query(~live) |> qwith() |> qwith() |> qwith() |> qflat3()
// }

// fn query_rrrr[A : Component, B : Component, C : Component, D : Component, E : Component](
//   ~live : Bool = true
// ) -> Array[(Entity, A, B, C, D, E)] {
//   query(~live) |> qwith() |> qwith() |> qwith() |> qwith() |> qflat4()
// }

// // fn query_o[A : Component, B : Component](
// //   ~live : Bool = true,
// // ) -> Array[(Entity, A, B?)] {
// //   query(~live) |> qwith_option() |> qflat1()
// // }

// // fn query_ro[A : Component, B : Component, C : Component](
// //   ~live : Bool = true,
// // ) -> Array[(Entity, A, B, C?)] {
// //   query(~live) |> qwith() |> qwith_option() |> qflat2()
// // }

// fn query_rro[A : Component, B : Component, C : Component, D : Component](
//   ~live : Bool = true
// ) -> Array[(Entity, A, B, C, D?)] {
//   query(~live) |> qwith() |> qwith() |> qwith_option() |> qflat3()
// }

// // fn query_rrro[A : Component, B : Component, C : Component, D : Component, E : Component](
// //   ~live : Bool = true,
// // ) -> Array[(Entity, A, B, C, D, E?)] {
// //   query(~live) |> qwith() |> qwith() |> qwith() |> qwith_option() |> qflat4()
// // }
