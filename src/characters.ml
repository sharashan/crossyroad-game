(*define types for objects in game*)

type player = {
  mutable location : int * int;
  speed : int;
  frame : int;
  mutable steps : int;
}

type obj =
  | Tree
  | Rock
  | Water

type obstacle = {
  object_type : obj;
  location : int * int;
}

type moving =
  | Log
  | Car

type moving_ob = {
  ob_type : moving;
  mutable location : int * int;
  speed : int;
  frame : int;
}

let trees (x : int) (y : int) =
  { object_type = Tree; location = (Random.int 1000 + x, Random.int 150 + y) }

let rock (x : int) (y : int) =
  { object_type = Rock; location = (Random.int 1000 + x, Random.int 200 + y) }

let car (ty : moving) (x : int) (y : int) (s : int) (f : int) =
  { ob_type = Car; location = (x, y); speed = s; frame = f }

let draw_oompa (t : player) x y =
  let a = t.location = (x, y) in
  let b = t.speed = 0 in
  let c = t.frame = 0 in
  let d = t.steps = 0 in
  Graphics.draw_rect x y 30 30
