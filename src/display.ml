open Graphics
open Characters
open Constants
open Images

type color = {
  r : int;
  g : int;
  b : int;
}

type arrows =
  | Up
  | Right
  | Left
  | Down

type input = {
  key_pressed : char;
  mouse_down : bool;
}

type t = {
  key_press : char;
  moves_list : input list;
}

type init = { mutable oompa : player }
type init2 = { mutable obstacle : obstacle }
type init3 = { mutable rock : obstacle }

type gui_images = {
  oompa_loompa : Graphics.image;
  trees : Graphics.image;
  cars : Graphics.image;
  rocks : Graphics.image;
  dead : Graphics.image;
}

type l = { images : gui_images }
type map = { map : t }

(** [init_l] initializes all the images used in the game*)
let init_l () =
  {
    images =
      {
        oompa_loompa =
          Image.of_image (Png.load "images/oompa_loompa.png" []) 0 0 0;
        trees = Image.of_image (Png.load "images/cotton_candy.png" []) 0 0 0;
        cars = Image.of_image (Png.load "images/cars.png" []) 0 0 0;
        rocks = Image.of_image (Png.load "images/rocks.png" []) 0 0 0;
        dead = Image.of_image (Png.load "images/dead.png" []) 0 0 0;
      };
  }

let _ = Random.self_init ()

(** [init] initializes a main player. *)
let init =
  {
    oompa =
      {
        location = (500, 30);
        speed = 0;
        frame = 0;
        steps = 0;
        oompa_width = 30;
        oompa_height = 30;
      };
  }

(** [init2] initializes an tree of type obstacle. *)
let init2 = { obstacle = { object_type = Tree; location = (100, 100) } }

(** [init3] initializes an rock of type obstacle. *)
let init3 = { rock = { object_type = Rock; location = (100, 650) } }

(** [init_car] initializes a car*)
let init_car = car Car 0 150 0 10 0 Right

(** [init_car2] initializes a car moving left*)
let init_car_2 = car Car 100 300 0 10 0 Left

(** [init_car3] initializes a car on the second road*)
let init_car_3 = car Car 300 800 0 10 0 Left

(** [move_lst] adds the cars to a list*)
let move_lst = [ init_car; init_car_2 ]

(** [map_init] initializes type t*)
let map_init =
  { oompa = init.oompa; characters_moving = move_lst; state = Pause }

(**[init_t] initializes type t*)
let init_t = { oompa = init.oompa; characters_moving = move_lst; state = Play }

(** [init_car_list] initializes a list of type movable objects*)
let init_car_list = { hist_cars = [] }

type pain_init = { trees : obstacle }
type rock_init = { rocks : obstacle }

(** [pain_init] initializes a tree obstacle*)
let pain_init (y : int) =
  {
    trees =
      { object_type = Tree; location = (Random.int 1000, Random.int 150 + y) };
  }

(** [rock_init] initializes a rock obstacle*)
let rock_init =
  {
    rocks = { object_type = Rock; location = (Random.int 1000, Random.int 150) };
  }

(** [obstacle_lst] creates a list of trees.*)
let obstacle_lst = [ init2.obstacle ]

(** [obstacle_lst] creates a list of rocks. *)
let rock_lst = [ init3.rock ]

(** [text s size color] defines the set string, size, and color for the text *)
let text text size color =
  Graphics.set_color color;
  Graphics.draw_string text;
  Graphics.set_text_size size

(** [take_a_step oompa] tracks the number of steps oompa takes. *)
let take_a_step (oompa : player) = oompa.steps <- oompa.steps + 1

(** [create_issues_1] creates trees on the first patch of grass on the map*)
let create_issues_1 lst =
  match lst with
  | [] -> [ (pain_init 0).trees ]
  | h :: t -> (pain_init 0).trees :: h :: t

(** [create_issues_2] creates trees on the second patch of grass on the map*)
let create_issues_2 lst =
  match lst with
  | [] -> [ (pain_init 400).trees ]
  | h :: t -> (pain_init 400).trees :: h :: t

(** [create_issues_3] creates rocks in the water on the map*)
let create_issues_3 lst =
  match lst with
  | [] -> [ rock_init.rocks ]
  | h :: t -> rock_init.rocks :: h :: t

(* tree height*)
let tree_h_int = int_of_float Constants.tree_height

(* rock height*)
let rock_h_int = int_of_float Constants.rock_height

(* tree width*)
let tree_w_int = int_of_float Constants.tree_width

(* rock width*)
let rock_w_int = int_of_float Constants.rock_width

(** [x_lst] stores the values of the x-coordinates of the first set of trees. *)
let x_lst =
  [|
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
  |]

(** [x_lst2] stores the values of the x-coordinates of the second set of trees.*)
let x_lst2 =
  [|
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
  |]

(** [x_lst3] stores the values of the x-coordinates of the set of rocks. *)
let x_lst3 =
  [|
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
  |]

(** [check_x ] checks if the set of x-coordinates for the obstacles stay within
    the bounds of the map *)
let check_x x =
  if x < 100 then x + 50
  else if x > 900 then x - 50
  else if x = 50 then x + 50
  else x

(** [map f lst] applies f to every element in lst. *)
let map f lst = Array.map f lst

(** [sleep x] delays the implementation of the game for x seconds*)
let sleep time =
  let start = Unix.gettimeofday () in
  let rec stop t =
    try ignore (Unix.select [] [] [] t)
    with Unix.Unix_error (Unix.EINTR, _, _) ->
      let current = Unix.gettimeofday () in
      let r = start +. time -. current in
      if r > 0.0 then stop r
  in
  stop time

(** [y_lst] stores the values of the y-coordinates of the first set of trees. *)
let y_lst =
  [|
    Random.int 140 + 10;
    Random.int 140 + 10;
    Random.int 140 + 10;
    Random.int 140 + 10;
    Random.int 140 + 10;
  |]

(** [y_lst2] stores the values of the y-coordinates of the second set of trees. *)
let y_lst2 =
  [|
    Random.int 550;
    Random.int 550;
    Random.int 550;
    Random.int 550;
    Random.int 550;
  |]

(** [y_lst3] stores the values of the y-coordinates of the set of rocks. *)
let y_lst3 =
  [|
    Random.int 750;
    Random.int 750;
    Random.int 750;
    Random.int 750;
    Random.int 750;
  |]

type button = {
  bottom_corner : int * int;
  height : int;
  width : int;
}

(** [init_pause_button] initializes the pause button in the game*)
let init_pause_button = { bottom_corner = (10, 810); height = 40; width = 40 }

(** [draw_box button] draws a rectangle to represent the button*)
let draw_box (button_dims : button) () =
  Graphics.draw_rect
    (fst button_dims.bottom_corner)
    (snd button_dims.bottom_corner)
    button_dims.height button_dims.width

(** [draw_pause_button] adds details on the empty rectangle to represent pause*)
let draw_pause_button () =
  Graphics.set_color Graphics.black;
  draw_box init_pause_button ();
  Graphics.draw_rect 20 820 5 20;
  Graphics.fill_rect 20 820 5 20;
  Graphics.draw_rect 35 820 5 20;
  Graphics.fill_rect 35 820 5 20

(*let mouse_in_bounds (button_dims : button) (x, y) = if fst
  button_dims.bottom_corner <= x && x < fst button_dims.bottom_corner +
  button_dims.width then snd button_dims.bottom_corner < y && y < snd
  button_dims.bottom_corner + button_dims.height else false *)

(** [get_pause_input] pauses the game and changes the game state to pause*)
let get_pause_input () =
  Characters.update_game_state map_init;
  State.update_state "pause";
  State.draw_pause_screen ();
  let input2 = Graphics.read_key () in
  if input2 <> 'a' then State.draw_fail_screen ()

(** [check_y1 x] checks if the set of y-coordinates for the first set of trees
    stay within the bounds of the first patch of grass. *)
let check_y1 x =
  if x < 50 then x + 50
  else if x >= 100 then x - 50
  else if x = 50 then x + 50
  else x

(** [check_y2 x] checks if the set of y-coordinates for the second set of trees
    stay within the bounds of the second patch of grass. *)
let check_y2 x =
  if x < 100 then x + 400
  else if x < 200 then x + 300
  else if x < 300 then x + 200
  else if x < 400 then x + 100
  else if x >= 500 then x - 50
  else x

(** [check_y3 x] checks if the set of y-coordinates for the set of rocks stay
    within the bounds of the water. *)
let check_y3 x =
  if x < 100 then x + 600
  else if x < 200 then x + 500
  else if x < 300 then x + 400
  else if x < 400 then x + 300
  else if x < 500 then x + 200
  else if x < 600 then x + 100
  else if x >= 700 then x - 50
  else x

(** [draw_draw_obstacles h y] iteratively draws five trees in random coordinates
    in the first patch of grass. *)
let draw_draw_obstacles st h y =
  for x = 0 to 4 do
    Graphics.set_color Graphics.red;
    Graphics.draw_image st.images.trees
      (map check_x x_lst).(x)
      (map check_y1 y_lst).(x)
  done

(** [draw_obstacles h y] iteratively draws five trees in random coordinates in
    the second patch of grass. *)
let draw_obstacles st h y =
  for x = 0 to 4 do
    Graphics.set_color Graphics.red;
    Graphics.draw_image st.images.trees
      (map check_x x_lst2).(x)
      (map check_y2 y_lst2).(x)
  done

(** [draw_rocks h y] iteratively draws five rocks in random coordinates in the
    water. *)
let draw_rocks st h y =
  for x = 0 to 4 do
    Graphics.set_color (Graphics.rgb 102 204 0);
    Graphics.draw_image st.images.rocks
      (map check_x x_lst3).(x)
      (map check_y3 y_lst3).(x)
  done

(** [draw_score] is the helper that [start] calls on to draw the score. *)
let draw_score () =
  Graphics.moveto 750 800;
  text "Score: " 200 Graphics.black;
  Graphics.draw_string (string_of_int init.oompa.steps)

(** [draw_oompa] is the helper that [start] calls on to draw the main player. *)
let draw_oompa st () =
  Graphics.draw_image st.images.oompa_loompa (fst init.oompa.location)
    (snd init.oompa.location)

(** [draw_background] is the helper that [start] calls on to draw the background
    elements, like the obstacles. *)
let draw_background st () =
  draw_draw_obstacles st obstacle_lst 0;
  draw_obstacles st obstacle_lst 400;
  draw_rocks st rock_lst 600;
  draw_score ()

(** [update_car_1] draws the first car in its defined coordinates. *)
let rec update_car_1 st () =
  Graphics.set_color Graphics.black;
  Graphics.draw_image st.images.cars (fst init_car.location)
    (snd init_car.location);
  add_car init_car_list init_car;
  updateCar init_car init_car_list.hist_cars 1

(** [update_car_2] draws the first car in its defined coordinates. *)
let update_car_2 st () =
  Graphics.set_color Graphics.black;
  Graphics.draw_image st.images.cars (fst init_car_3.location)
    (snd init_car_3.location);
  add_car init_car_list init_car_3;
  move_car init_car_3 init_car_list.hist_cars 1;
  updateCar init_car_3 init_car_list.hist_cars 1

(** [update_car_3] draws the first car in its defined coordinates. *)
let update_car_3 st () =
  Graphics.set_color Graphics.black;
  Graphics.draw_image st.images.cars (fst init_car_2.location)
    (snd init_car_2.location);
  add_car init_car_list init_car_2;
  move_car init_car_2 init_car_list.hist_cars 1;
  updateCar init_car_2 init_car_list.hist_cars 1

(** [check_coll l cs] checks to see whether a moving object collides the player. *)
let check_coll l cs = Characters.check_coll l cs

(** [collision_car] checks to see if the player collides with the cars.*)
let rec collision_car (oompa : player) (car : moving_ob)
    (hist_lst : moving_ob list) =
  match hist_lst with
  | [] -> false
  | h :: t ->
      if
        abs (fst oompa.location - fst car.location)
        <= (car_width / 2) + (init.oompa.oompa_width / 2)
        && abs (snd oompa.location - snd car.location)
           <= (car_height / 2) + (init.oompa.oompa_height / 2)
      then true
      else false && collision_car oompa h t

(** [collision oompa lst] returns true if [oompa], the main player, collides
    with any of the obstacles in the game board. *)
let rec collision (oompa : player) lst =
  match obstacle_lst with
  | [] -> false
  | h :: t ->
      if
        abs ((map check_x x_lst).(0) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (tree_w_int / 2)
        && abs ((map check_y1 y_lst).(0) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst).(1) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (tree_w_int / 2)
        && abs ((map check_y1 y_lst).(1) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst).(2) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (tree_w_int / 2)
        && abs ((map check_y1 y_lst).(2) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst).(3) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (tree_w_int / 2)
        && abs ((map check_y1 y_lst).(3) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst).(4) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (tree_w_int / 2)
        && abs ((map check_y1 y_lst).(4) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst2).(0) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (tree_w_int / 2)
        && abs ((map check_y2 y_lst2).(0) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst2).(1) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (tree_w_int / 2)
        && abs ((map check_y2 y_lst2).(1) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst2).(2) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (tree_w_int / 2)
        && abs ((map check_y2 y_lst2).(2) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst2).(3) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (tree_w_int / 2)
        && abs ((map check_y2 y_lst2).(3) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst2).(4) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (tree_w_int / 2)
        && abs ((map check_y2 y_lst2).(4) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst3).(0) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (rock_w_int / 2)
        && abs ((map check_y3 y_lst3).(0) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (rock_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst3).(1) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (rock_w_int / 2)
        && abs ((map check_y3 y_lst3).(1) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (rock_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst3).(2) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (rock_w_int / 2)
        && abs ((map check_y3 y_lst3).(2) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (rock_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst3).(3) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (rock_w_int / 2)
        && abs ((map check_y3 y_lst3).(3) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (rock_h_int / 2)
      then true
      else if
        abs ((map check_x x_lst3).(4) - fst oompa.location)
        <= (init.oompa.oompa_width / 2) + (rock_w_int / 2)
        && abs ((map check_y3 y_lst3).(4) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (rock_h_int / 2)
      then true
      else false && collision oompa t

(** [reach_top oompa] returns true if the main player reaches the other side of
    the game board (i.e. the greatest y-coordinate). *)
let reach_top (oompa : player) =
  if snd oompa.location > 850 then true else false

(** [move_oompa oompa new_input move_lst] implements the action required by the
    input key pressed by the user. *)
let move_oompa (oompa : player) new_input move_lst =
  match new_input with
  | 'p' -> get_pause_input ()
  | 'a' ->
      oompa.location <-
        (if fst oompa.location - 10 > 0 then
         (fst oompa.location - 10, snd oompa.location)
        else oompa.location)
  | 'w' ->
      oompa.location <-
        (if snd oompa.location + 10 < 1000 then (
         take_a_step oompa;
         (fst oompa.location, snd oompa.location + 10))
        else oompa.location)
  | 's' ->
      oompa.location <-
        (if snd oompa.location - 10 > 0 then
         (fst oompa.location, snd oompa.location - 10)
        else failwith "YOU FAILED")
  | 'd' ->
      oompa.location <-
        (if fst oompa.location + 40 < 1000 then
         (fst oompa.location + 10, snd oompa.location)
        else oompa.location)
  | _ -> failwith "Not a proper move"

(** [start oompa lst] draws all of the elements on the gameboard using the OCaml
    Graphics module (e.g. the water,road, and grass). *)
let rec start (oompa : player) (lst : obstacle list) =
  Constants.background_crossy ();
  draw_pause_button ();
  update_car_1 (init_l ()) ();
  update_car_2 (init_l ()) ();
  update_car_3 (init_l ()) ();
  draw_draw_obstacles (init_l ()) obstacle_lst 0;
  draw_obstacles (init_l ()) obstacle_lst 0;
  draw_rocks (init_l ()) rock_lst 0;
  draw_score ();
  draw_oompa (init_l ()) ();
  let input_2 = Graphics.read_key () in
  move_oompa init.oompa input_2 [];
  Graphics.moveto (fst init.oompa.location) (snd init.oompa.location);
  draw_oompa (init_l ()) ();
  if
    collision oompa obstacle_lst
    || collision_car oompa init_car init_car_list.hist_cars
    || collision_car oompa init_car_3 init_car_list.hist_cars
    || collision_car oompa init_car_2 init_car_list.hist_cars
  then (
    Graphics.set_color Graphics.blue;
    Graphics.draw_image (init_l ()).images.dead (fst init.oompa.location)
      (snd init.oompa.location);
    sleep 1.0;
    Graphics.clear_graph ();
    Graphics.set_color Graphics.blue;
    State.draw_fail_screen ();
    State.update_state "fail")
  else if reach_top oompa then (
    State.draw_win_screen ();
    State.update_state "win")
  else start oompa lst

(** [get_start_input] draws the start screen. *)
let rec get_start_input () =
  let input = Graphics.read_key () in
  if input = 'a' then (
    Graphics.clear_graph ();
    Graphics.set_color Graphics.black;
    Graphics.draw_rect 100 100 50 50;
    start init.oompa obstacle_lst)
  else (
    Graphics.clear_graph ();
    Graphics.moveto 400 420;
    text "Try Again" 500 Graphics.black;
    get_start_input ())
