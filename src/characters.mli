(*Representation of the different "characters" in the game.

  This module outlines the different types of objects in the game, including
  player, obj (non-moving obstacles), and moving (moving obstacles). Each of
  these has its own types that represent different objects.

  *****************************************************************************)

(*The player type represents the record fields of the main player, which include
  location, speed, frame, steps, width, and height*)
type player = {
  mutable location : int * int;
  speed : int;
  frame : int;
  mutable steps : int;
  oompa_width : int;
  oompa_height : int;
}

(*The obj type represents the non-moving objects, which include the trees, the
  rocks, and the water*)
type obj =
  | Tree
  | Rock
  | Water

(*The obstacle type represents the non-moving obstacles of the game and it also
  includes a record field defining their location*)
type obstacle = {
  object_type : obj;
  location : int * int;
}

(*The moving type represents the moving objects/obstacles. In this game, it is a
  car*)
type moving =
  | Log
  | Car

(*The direction type represents the direction the cars move in. Right is moving
  in the positive x direction and Left is moving in the negative x direction*)
type direction =
  | Right
  | Left

(*The moving_ob type defines record fields location, time, speed, frame, and
  direction for the moving objects*)
type moving_ob = {
  ob_type : moving;
  mutable location : int * int;
  mutable time : int;
  speed : int;
  frame : int;
  direction : direction;
}

(*The abstract type represents the main player, a list of moving objects, and
  the game state*)
type t = {
  oompa : player;
  characters_moving : moving_ob list;
  state : State.game_mode;
}

(*type e represents a Tick*)
type e = Tick

(*[car_walk_n c] decrements the x-coordinate of the location of c by the speed
  of c*)
val car_walk_n : moving_ob -> unit

(*[check_coll l cs] checks if the main player collides with a moving object. If
  it does, the object is returned. If not, None is returned*)
val check_coll : int * int -> moving_ob list -> moving_ob option

(*[update_game_state map] updates the map's field state with a new state*)
val update_game_state : t -> t

(*[tick map] updates the location of the moving object as long as the state of
  map is set to Play. The x-coordinate is incremented by the speed*)
val tick : t -> t

(*[handle_event map event]*)
val handle_event : t -> e -> t

(*[spawn_moving_ob l ob ] sets the record fields for a new moving object. l is
  the (x,y) coordinates for the location field. ob is the object that is
  spawned*)
val spawn_moving_ob : int * int -> moving -> moving_ob

(*car_list type represents a list of cars*)
type car_list = { mutable hist_cars : moving_ob list }

(*[car_width] is the width of the car*)
val car_width : int

(*[car_height] is the height of the car*)
val car_height : int

(*[car_walk] is the width of the car divided by 4*)
val car_walk : int

(*[trees x y] initializes an obstacle that is a tree with location set to be
  randomly generated coordinates with an x and y bound added to the respective
  coordinate*)
val trees : int -> int -> obstacle

(*[rocks x y] initializes an obstacle that is a rock with location set to be
  randomly generated coordinates with an x and y bound added to the respective
  coordinate*)
val rock : int -> int -> obstacle

(*[create_car_lst c] initializes a list of cars*)
val create_car_lst : car_list -> car_list

(*[add_car c car] adds car to the list c.hist_cars*)
val add_car : car_list -> moving_ob -> unit

(*[car type x y t s f d] initializes a car object with fields ob_type, location,
  time, speed, frame, and direction*)
val car : moving -> int -> int -> int -> int -> int -> direction -> moving_ob

(*[draw_car c] draws a car at the x and y coordinates specified by its location
  field*)
val draw_car : moving_ob -> unit -> unit

(*[move_car c hist] moves the car in the direction specified by its direction
  field. The car's x-coordinate is set to 0 if it drives out of frame*)
val move_car : moving_ob -> moving_ob list -> int -> unit

(*[updateCar c hist] calls [move_car c hist] to recursively move the car *)
val updateCar : moving_ob -> moving_ob list -> int -> unit
