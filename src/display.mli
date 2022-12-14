(*Representation and rendering of Crossy Road - Oompa Loompa Version.

    This module primarily draws the map or game board for the game. This 
    includes the various screens that pop up (depending on state changes), the
    main character, and the obstacles designed to make the game harder (e.g. 
    rocks, trees, etc.). In addition, it also draws background elements, like 
    water, grass, the road, and also keeps track of the score of the player
    
*******************************************************************************)

(*The color type represents the red, green, and blue concentration in colors
   using their associated interger values.*)
type color = {
  r : int;
  g : int;
  b : int;
}

(*The arrows type representes the different directions the player could 
   move in; this is associated with a key*)
type arrows =
  | Up
  | Right
  | Left
  | Down

(*The input type represents the input given my the player*)
type input = {
  key_pressed : char;
  mouse_down : bool;
}

type l

(*The type that initializes a main player. This is the player whose moves 
   are being controlled by the user*)
type init = { mutable oompa : Characters.player }

(*The type that initializes an obstacle of type obstacle. This specific type 
initializes a tree object*)
type init2 = { mutable obstacle : Characters.obstacle }

(*The type that initializes an obstacle of type obstacle. This specific type 
initializes a rock object*)
type init3 = { mutable rock : Characters.obstacle }

(*[init] initializes the main player in the game by declaring values for the 
   fields in the record. This involves initializing the location, frame, and
   steps*)
val init : init

(*[init2] initializes the tree obstacle in the game by declaring values for the 
   fields in the record. This involves initializing the location and object type
   *)
val init2 : init2

(*[init3] initializes the rock obstacle in the game by declaring values for the 
   fields in the record. This involves initializing the location and object type
   *)
val init3 : init3

type pain_init = { trees : Characters.obstacle }
type rock_init = { rocks : Characters.obstacle }

(*[paint_init] initializes a tree obstacle, but sets the record field location
   to be a randomly generated integer*)
val pain_init : int -> pain_init

(*[rock_init] initializes a rock obstacle, but sets the record field location
   to be a randomly generated integer*)
val rock_init : rock_init

(*[obstacle_lst] creates a list of obstacles. This list contains tree obstacles
   *)
val obstacle_lst : Characters.obstacle list

(*[obstacle_lst] creates a list of obstacles. This list contains rock obstacles
   *)
val rock_lst : Characters.obstacle list

val text : string -> int -> int -> unit

(*[take_a_step oompa] tracks the number of steps oompa takes. It increments the 
   step field in the record by one per step*)
val take_a_step : Characters.player -> unit

val print_list : Characters.obstacle list -> unit

val create_issues_1 : Characters.obstacle list -> Characters.obstacle list
val create_issues_2 : Characters.obstacle list -> Characters.obstacle list
val create_issues_3 : Characters.obstacle list -> Characters.obstacle list

(*[x_lst] stores the values of the x-coordinates of the first set of trees. It
 stores the randomly generated integers. The size of the array is 5 *)
val x_lst : int array

(*[x_lst2] stores the values of the x-coordinates of the second set of trees. It 
stores the randomly generated integers. The size of the array is 5 *)
val x_lst2 : int array

(*[x_lst3] stores the values of the x-coordinates of the set of rocks. It 
stores the randomly generated integers. The size of the array is 5 *)
val x_lst3 : int array

(*[map f lst] applies f to every element in lst*)
val map : ('a->'b) -> 'a array -> 'b array 

(*[y_lst] stores the values of the y-coordinates of the first set of trees. It 
stores the randomly generated integers. The size of the array is 5 *)
val y_lst : int array

(*[y_lst2] stores the values of the y-coordinates of the second set of trees. It 
stores the randomly generated integers. The size of the array is 5 *)
val y_lst2 : int array

(*[y_lst3] stores the values of the y-coordinates of the set of rocks. It 
stores the randomly generated integers. The size of the array is 5 *)
val y_lst3 : int array

(*[check_y1 x] checks if the set of y-coordinates for the first set of trees
   stay within the bounds of the first patch of grass*)
val check_y1 : int -> int 

(*[check_y2 x] checks if the set of y-coordinates for the second set of trees
   stay within the bounds of the second patch of grass*)
val check_y2 : int -> int 

(*[check_y3 x] checks if the set of y-coordinates for the set of rocks
   stay within the bounds of the water*)
val check_y3 : int -> int 

(*[draw_draw_obstacles h y] iteratively draws five trees in random coordinates
in the first patch of grass. [y] representes the dy that needs to be added to 
the randomly generated y-coordinates to place the trees in the right patch of 
grass*)
val draw_draw_obstacles : l -> 'a -> 'b -> unit

(*[draw_obstacles h y] iteratively draws five trees in random coordinates
in the second patch of grass. [y] representes the dy that needs to be added to 
the randomly generated y-coordinates to place the trees in the right patch of 
grass*)
val draw_obstacles : 'a -> int -> unit

(*[draw_rocks h y] iteratively draws five rocks in random coordinates
in the water. [y] representes the dy that needs to be added to 
the randomly generated y-coordinates to place the rocks within the width of the
water*)
val draw_rocks : 'a -> int -> unit

(*[draw_score] is the helper that [start] calls on to draw the score*)
val draw_score : unit -> unit 

(*[draw_oompa] is the helper that [start] calls on to draw the main player*)
val draw_oompa : l -> unit -> unit 

(*[draw_background] is the helper that [start] calls on to draw the background
   elements, like the obstacles*)
val draw_background : l -> unit -> unit 

(*[update_car_1] draws the first car in its defined coordinates*)
val update_car_1 : unit -> unit

(*[update_car_2] draws the first car in its defined coordinates*)
val update_car_2 : unit -> unit

(*[update_car_3] draws the first car in its defined coordinates*)
val update_car_3 : unit -> unit

val collision_car: Characters.player -> Characters.moving_ob -> 
   Characters.moving_ob list -> bool 

(*[collision oompa lst] returns true if [oompa], the main player, collides with
   any of the obstacles in the game board. This calculates if there is an 
  overlap between the coordinates of [oompa] and each tree and rock in the
  list.
  
  For example, if the difference between the x-coordinate of [oompa] and the 
    x-coordinate of a tree is less than the distance between each of their 
  midpoints, they will collide, and [collide] will return true*)
val collision : Characters.player -> Characters.obstacle list -> bool

(*[reach_top oompa] returns true if the main player reaches the other side of 
   the game board (i.e. the greatest y-coordinate). This means they have won the 
game, so state is updated and the appropriate screen is executed.*)
val reach_top : Characters.player -> bool

(*[move_oompa oompa new_input move_lst] implements the action required by the 
input key pressed by the user. It uses keys 'a', 'w', 's', and 'd' to represent
the directions [oompa] can move. It increments the location field of [oompa] by 
10 for each key press. Requires: a valid key (ones above) to be pressed*)
val move_oompa : Characters.player -> char -> 'a -> unit

(*[start oompa lst] draws all of the elements on the gameboard using the OCaml 
Graphics module (e.g. the water,road, and grass). It draws the ten trees and 
five rocks. It draws the score (i.e. the number of forward steps taken). It 
draws the main player. For each key input, the main player is re-drawn at the 
new coordinate location. Lastly, it also checks to see if the player collides
into obstacles; if it does, the fail screen is drawn and state is updated. *)
val start : Characters.player -> Characters.obstacle list -> State.t -> unit

(*[get_start_input] draws the start screen. It takes an input of key 'a' to 
   start the game. If 'a' is pressed, [start] is executed. If not, an error 
   message is printed.*)
val get_start_input : unit -> State.t -> unit

