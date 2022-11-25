(*define types for objects in game*)

type player = {
  location : int * int;
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
