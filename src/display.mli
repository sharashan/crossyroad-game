(** Representation and rendering of Crossy Road - Oompa Loompa Version.

    This module primarily draws the map or game board for the game. This
    includes the various screens that pop up (depending on state changes), the
    main character, and the obstacles designed to make the game harder (e.g.
    rocks, trees, etc.). In addition, it also draws background elements, like
    water, grass, the road, and also keeps track of the score of the player *)

(******************************************************************************)

type color = {
  r : int;
  g : int;
  b : int;
}
(** The color type represents the red, green, and blue concentration in colors
    using their associated interger values. *)

type arrows =
  | Up
  | Right
  | Left
  | Down

(** The arrows type representes the different directions the player could move
    in; this is associated with a key. *)

type input = {
  key_pressed : char;
  mouse_down : bool;
}
(** The input type represents the input given my the player. *)

type t = {
  key_press : char;
  moves_list : input list;
}
(** The abstract type t represents the history of all of the moves of the player *)

type gui_images = {
  oompa_loompa : Graphics.image;
  trees : Graphics.image;
  cars : Graphics.image;
  rocks : Graphics.image;
  dead : Graphics.image;
}
(** The gui_images type represents all the objects in the game*)

type l = { images : gui_images }
(** The images type represents all the images we use as players in the game*)

type map = { map : t }
(** The map type contains the player, moving objects, and game state*)

type init = { mutable oompa : Characters.player }
(** The type that initializes a main player. This is the player whose moves are
    being controlled by the user. *)

type init2 = { mutable obstacle : Characters.obstacle }
(** The type that initializes an obstacle of type obstacle. This specific type
    initializes a tree object. *)

type init3 = { mutable rock : Characters.obstacle }
(** The type that initializes an obstacle of type obstacle. This specific type
    initializes a rock object. *)

val init_l : unit -> l
(** [init_l] initializes all the images used in the game*)

val init : init
(** [init] initializes the main player in the game by declaring values for the
    fields in the record. This involves initializing the location, frame, and
    steps. *)

val init2 : init2
(** [init2] initializes the tree obstacle in the game by declaring values for
    the fields in the record. This involves initializing the location and object
    type. *)

val init3 : init3
(** [init3] initializes the rock obstacle in the game by declaring values for
    the fields in the record. This involves initializing the location and object
    type. *)

val map_init : Characters.t
(** [map_init] initializes type t*)

type pain_init = { trees : Characters.obstacle }
(** the pain_init type that initializes the obstacle tree*)

type rock_init = { rocks : Characters.obstacle }
(** the rock_init type that initializes the obstacle rock*)

val pain_init : int -> pain_init
(** [pain_init] initializes a tree obstacle, but sets the record field location
    to be a randomly generated integer. *)

val rock_init : rock_init
(** [rock_init] initializes a rock obstacle, but sets the record field location
    to be a randomly generated integer. *)

val obstacle_lst : Characters.obstacle list
(** [obstacle_lst] creates a list of obstacles. This list contains tree
    obstacles. *)

val rock_lst : Characters.obstacle list
(** [obstacle_lst] creates a list of obstacles. This list contains rock
    obstacles. *)

val text : string -> int -> int -> unit
(** [text s size color] defines the set string, size, and color for the text
    that will be printed out on each screen. *)

val take_a_step : Characters.player -> unit
(** [take_a_step oompa] tracks the number of steps oompa takes. It increments
    the step field in the record by one per step. *)

val create_issues_1 : Characters.obstacle list -> Characters.obstacle list
(** [create_issues_1] creates trees on the first patch of grass on the map*)

val create_issues_2 : Characters.obstacle list -> Characters.obstacle list
(** [create_issues_2] creates trees on the second patch of grass on the map*)

val create_issues_3 : Characters.obstacle list -> Characters.obstacle list
(** [create_issues_3] creates rocks in the water on the map*)

val x_lst : int array
(** [x_lst] stores the values of the x-coordinates of the first set of trees. It
    stores the randomly generated integers. The size of the array is 5. *)

val x_lst2 : int array
(** [x_lst2] stores the values of the x-coordinates of the second set of trees.
    It stores the randomly generated integers. The size of the array is 5. *)

val x_lst3 : int array
(** [x_lst3] stores the values of the x-coordinates of the set of rocks. It
    stores the randomly generated integers. The size of the array is 5. *)

val check_x : int -> int
(** [check_x ] checks if the set of x-coordinates for the obstacles stay within
    the bounds of the map *)

val map : ('a -> 'b) -> 'a array -> 'b array
(** [map f lst] applies f to every element in lst. *)

val y_lst : int array
(** [y_lst] stores the values of the y-coordinates of the first set of trees. It
    stores the randomly generated integers. The size of the array is 5. *)

val y_lst2 : int array
(** [y_lst2] stores the values of the y-coordinates of the second set of trees.
    It stores the randomly generated integers. The size of the array is 5. *)

val y_lst3 : int array
(** [y_lst3] stores the values of the y-coordinates of the set of rocks. It
    stores the randomly generated integers. The size of the array is 5. *)

val check_y1 : int -> int
(** [check_y1 x] checks if the set of y-coordinates for the first set of trees
    stay within the bounds of the first patch of grass. *)

val check_y2 : int -> int
(** [check_y2 x] checks if the set of y-coordinates for the second set of trees
    stay within the bounds of the second patch of grass. *)

val check_y3 : int -> int
(** [check_y3 x] checks if the set of y-coordinates for the set of rocks stay
    within the bounds of the water. *)

val sleep : float -> unit
(** [sleep x] delays the implementation of the game for x seconds*)

type button = {
  bottom_corner : int * int;
  height : int;
  width : int;
}
(** The button type creates a button on the game*)

val init_pause_button : button
(** [init_pause_button] initializes the pause button in the game*)

val draw_box : button -> unit -> unit
(** [draw_box button] draws a rectangle to represent the button*)

val draw_pause_button : unit -> unit
(** [draw_pause_button] adds details on the empty rectangle to represent pause*)

val get_pause_input : unit -> unit
(** [get_pause_input] pauses the game and changes the game state to pause*)

val draw_draw_obstacles : l -> 'a -> 'b -> unit
(** [draw_draw_obstacles h y] iteratively draws five trees in random coordinates
    in the first patch of grass. [y] representes the dy that needs to be added
    to the randomly generated y-coordinates to place the trees in the right
    patch of grass. *)

val draw_obstacles : l -> 'a -> int -> unit
(** [draw_obstacles h y] iteratively draws five trees in random coordinates in
    the second patch of grass. [y] representes the dy that needs to be added to
    the randomly generated y-coordinates to place the trees in the right patch
    of grass. *)

val draw_rocks : l -> 'a -> int -> unit
(** [draw_rocks h y] iteratively draws five rocks in random coordinates in the
    water. [y] representes the dy that needs to be added to the randomly
    generated y-coordinates to place the rocks within the width of the water. *)

val draw_score : unit -> unit
(** [draw_score] is the helper that [start] calls on to draw the score. *)

val draw_oompa : l -> unit -> unit
(** [draw_oompa] is the helper that [start] calls on to draw the main player. *)

val draw_background : l -> unit -> unit
(** [draw_background] is the helper that [start] calls on to draw the background
    elements, like the obstacles. *)

val update_car_1 : l -> unit -> unit
(** [update_car_1] draws the first car in its defined coordinates. *)

val update_car_2 : l -> unit -> unit
(** [update_car_2] draws the first car in its defined coordinates. *)

val update_car_3 : l -> unit -> unit
(** [update_car_3] draws the first car in its defined coordinates. *)

val collision_car :
  Characters.player -> Characters.moving_ob -> Characters.moving_ob list -> bool
(** [collision_car] checks to see if the player collides with the cars.*)

val collision : Characters.player -> Characters.obstacle list -> bool
(** [collision oompa lst] returns true if [oompa], the main player, collides
    with any of the obstacles in the game board. This calculates if there is an
    overlap between the coordinates of [oompa] and each tree and rock in the
    list.

    For example, if the difference between the x-coordinate of [oompa] and the
    x-coordinate of a tree is less than the distance between each of their
    midpoints, they will collide, and [collide] will return true. *)

val reach_top : Characters.player -> bool
(** [reach_top oompa] returns true if the main player reaches the other side of
    the game board (i.e. the greatest y-coordinate). This means they have won
    the game, so state is updated and the appropriate screen is executed. *)

val move_oompa : Characters.player -> char -> 'a -> unit
(** [move_oompa oompa new_input move_lst] implements the action required by the
    input key pressed by the user. It uses keys 'a', 'w', 's', and 'd' to
    represent the directions [oompa] can move. It increments the location field
    of [oompa] by 10 for each key press. Requires: a valid key (ones above) to
    be pressed. *)

val start : Characters.player -> Characters.obstacle list -> State.t -> unit
(** [start oompa lst] draws all of the elements on the gameboard using the OCaml
    Graphics module (e.g. the water,road, and grass). It draws the ten trees and
    five rocks. It draws the score (i.e. the number of forward steps taken). It
    draws the main player. For each key input, the main player is re-drawn at
    the new coordinate location. Lastly, it also checks to see if the player
    collides into obstacles; if it does, the fail screen is drawn and state is
    updated. *)

val get_start_input : unit -> State.t -> unit
(** [get_start_input] draws the start screen. It takes an input of key 'a' to
    start the game. If 'a' is pressed, [start] is executed. If not, an error
    message is printed. *)
