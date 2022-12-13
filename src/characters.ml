(*define types for objects in game*)

type player = {
  mutable location : int * int;
  speed : int;
  frame : int;
  mutable steps : int;
}

let draw_oompa (t : player) x y =
  let a = t.location = (x, y) in
  let b = t.speed = 0 in
  let c = t.frame = 0 in
  let d = t.steps = 0 in
  Graphics.draw_rect x y 30 30
