(** Representation of the different "characters" in the game.

    This module outlines the different types of objects in the game, including
    player, obj (non-moving obstacles), and moving (moving obstacles). Each of
    these has its own types that represent different objects. *)

(*****************************************************************************)

type player = {
  mutable location : int * int;
  speed : int;
  frame : int;
  mutable steps : int;
  oompa_width : int;
  oompa_height : int;
}
(*The player type represents the record fields of the main player, which include
  location, speed, frame, steps, width, and height*)

type obj =
  | Tree
  | Rock
  | Water
(*The obj type represents the non-moving objects, which include the trees, the
  rocks, and the water*)

type obstacle = {
  object_type : obj;
  location : int * int;
}
(*The obstacle type represents the non-moving obstacles of the game and it also
  includes a record field defining their location*)

type moving = Car
(*The moving type represents the moving objects/obstacles. In this game, it is a
  car*)

type direction =
  | Right
  | Left
(*The direction type represents the direction the cars move in. Right is moving
  in the positive x direction and Left is moving in the negative x direction*)

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
(*The moving_ob type defines record fields location, time, speed, frame, and
  direction for the moving objects*)

type t = {
  oompa : player;
  characters_moving : moving_ob list;
  state : State.game_mode;
}
(*The abstract type represents the main player, a list of moving objects, and
  the game state*)

type e = Tick
(*type e represents a Tick*)

val car_walk_n : moving_ob -> unit
(*[car_walk_n c] decrements the x-coordinate of the location of c by the speed
  of c*)

val check_coll : int * int -> moving_ob list -> moving_ob option
(*[check_coll l cs] checks if the main player collides with a moving object. If
  it does, the object is returned. If not, None is returned*)

val update_game_state : t -> t
(*[update_game_state map] updates the map's field state with a new state*)

val tick : t -> t
(*[tick map] updates the location of the moving object as long as the state of
  map is set to Play. The x-coordinate is incremented by the speed*)

val handle_event : t -> e -> t
(*[handle_event map event] applies tick to each event passed in, so that the
  events are properly changed by tick *)

val spawn_moving_ob : int * int -> moving -> moving_ob
(*[spawn_moving_ob l ob ] sets the record fields for a new moving object. l is
  the (x,y) coordinates for the location field. ob is the object that is
  spawned*)

type car_list = { mutable hist_cars : moving_ob list }
(*car_list type represents a list of cars*)

val car_width : int
(*[car_width] is the width of the car*)

val car_height : int
(*[car_height] is the height of the car*)

val car_walk : int
(*[car_walk] is the width of the car divided by 4*)

val trees : int -> int -> obstacle
(*[trees x y] initializes an obstacle that is a tree with location set to be
  randomly generated coordinates with an x and y bound added to the respective
  coordinate*)

val rock : int -> int -> obstacle
(*[rocks x y] initializes an obstacle that is a rock with location set to be
  randomly generated coordinates with an x and y bound added to the respective
  coordinate*)

val create_car_lst : car_list -> car_list
(*[create_car_lst c] initializes a list of cars*)

val add_car : car_list -> moving_ob -> unit
(*[add_car c car] adds car to the list c.hist_cars*)

val car : moving -> int -> int -> int -> int -> int -> direction -> moving_ob
(*[car type x y t s f d] initializes a car object with fields ob_type, location,
  time, speed, frame, and direction*)

val draw_car : moving_ob -> unit -> unit
(*[draw_car c] draws a car at the x and y coordinates specified by its location
  field*)

val move_car : moving_ob -> moving_ob list -> int -> unit
(*[move_car c hist] moves the car in the direction specified by its direction
  field. The car's x-coordinate is set to 0 if it drives out of frame*)

val updateCar : moving_ob -> moving_ob list -> int -> unit
(*[updateCar c hist] calls [move_car c hist] to recursively move the car *)
