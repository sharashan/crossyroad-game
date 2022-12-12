(*define types for objects in game*)

type player = {
  mutable location : int * int;
  speed : int;
  frame : int;
  steps : int;
}

type obstacle_type =
  | Tree
  | Log
  | River
  | Road
  | Grass

type obstacle = {
  object_type : obstacle_type;
  location : int * int;
  speed : int;
}

let draw_oompa (t : player) x y =
  let a = t.location = (x, y) in
  let b = t.speed = 0 in
  let c = t.frame = 0 in
  let d = t.steps = 0 in
  Graphics.draw_rect x y 30 30
