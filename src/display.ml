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

<<<<<<< HEAD
=======
type row = { mutable cars : moving_ob list }

let init_row = { cars = [] }

>>>>>>> c1050eff5284e9d22f85d1c3baaa903a0d069e8e
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

let init2 = { obstacle = { object_type = Tree; location = (100, 100) } }
let init3 = { rock = { object_type = Rock; location = (100, 650) } }
let init_car = car Car 0 150 0 10 0 Right
let init_car_2 = car Car 100 300 0 10 0 Left
let init_car_3 = car Car 300 800 0 10 0 Left
let move_lst = [ init_car; init_car_2 ]

let map_init =
  { oompa = init.oompa; characters_moving = move_lst; state = Pause }

let init_t = { oompa = init.oompa; characters_moving = move_lst; state = Play }
let init_car_list = { hist_cars = [] }

type pain_init = { trees : obstacle }
type rock_init = { rocks : obstacle }

let pain_init (y : int) =
  {
    trees =
      { object_type = Tree; location = (Random.int 1000, Random.int 150 + y) };
  }

let rock_init =
  {
    rocks = { object_type = Rock; location = (Random.int 1000, Random.int 150) };
  }

let obstacle_lst = [ init2.obstacle ]
let rock_lst = [ init3.rock ]

let text text size color =
  Graphics.set_color color;
  Graphics.draw_string text;
  Graphics.set_text_size size

let take_a_step (oompa : player) = oompa.steps <- oompa.steps + 1

let rec print_list (lst : obstacle list) =
  match lst with
  | [] -> ()
  | h :: t ->
      print_endline (string_of_int (fst h.location));
      print_string " ";
      print_list t

let create_issues_1 lst =
  match lst with
  | [] -> [ (pain_init 0).trees ]
  | h :: t -> (pain_init 0).trees :: h :: t

let create_issues_2 lst =
  match lst with
  | [] -> [ (pain_init 400).trees ]
  | h :: t -> (pain_init 400).trees :: h :: t

let create_issues_3 lst =
  match lst with
  | [] -> [ rock_init.rocks ]
  | h :: t -> rock_init.rocks :: h :: t

let tree_h_int = int_of_float Constants.tree_height
let rock_h_int = int_of_float Constants.rock_height
let tree_w_int = int_of_float Constants.tree_width
let rock_w_int = int_of_float Constants.rock_width

let x_lst =
  [|
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
  |]

let x_lst2 =
  [|
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
  |]

let x_lst3 =
  [|
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
    Random.int 1000;
  |]

let check_x x =
  if x < 100 then x + 50
  else if x > 900 then x - 50
  else if x = 50 then x + 50
  else x

let map f lst = Array.map f lst

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

let y_lst =
  [|
    Random.int 140 + 10;
    Random.int 140 + 10;
    Random.int 140 + 10;
    Random.int 140 + 10;
    Random.int 140 + 10;
  |]

let y_lst2 =
  [|
    Random.int 550;
    Random.int 550;
    Random.int 550;
    Random.int 550;
    Random.int 550;
  |]

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

let init_pause_button = { bottom_corner = (10, 810); height = 40; width = 40 }

let draw_box (button_dims : button) () =
  Graphics.draw_rect
    (fst button_dims.bottom_corner)
    (snd button_dims.bottom_corner)
    button_dims.height button_dims.width

let draw_pause_button () =
  Graphics.set_color Graphics.black;
  draw_box init_pause_button ();
  Graphics.draw_rect 20 820 5 20;
  Graphics.fill_rect 20 820 5 20;
  Graphics.draw_rect 35 820 5 20;
  Graphics.fill_rect 35 820 5 20

let mouse_in_bounds (button_dims : button) (x, y) =
  if
    fst button_dims.bottom_corner <= x
    && x < fst button_dims.bottom_corner + button_dims.width
  then
    snd button_dims.bottom_corner < y
    && y < snd button_dims.bottom_corner + button_dims.height
  else false

let get_pause_input () =
  Characters.update_game_state map_init;
  State.update_state "pause";
  State.draw_pause_screen ();
  let input2 = Graphics.read_key () in
  if input2 <> 'a' then State.draw_fail_screen ()

let check_y1 x =
  if x < 50 then x + 50
  else if x >= 100 then x - 50
  else if x = 50 then x + 50
  else x

let check_y2 x =
  if x < 100 then x + 400
  else if x < 200 then x + 300
  else if x < 300 then x + 200
  else if x < 400 then x + 100
  else if x >= 500 then x - 50
  else x

let check_y3 x =
  if x < 100 then x + 600
  else if x < 200 then x + 500
  else if x < 300 then x + 400
  else if x < 400 then x + 300
  else if x < 500 then x + 200
  else if x < 600 then x + 100
  else if x >= 700 then x - 50
  else x

let draw_draw_obstacles st h y =
  for x = 0 to 4 do
    Graphics.set_color Graphics.red;
    Graphics.draw_image st.images.trees
      (map check_x x_lst).(x)
      (map check_y1 y_lst).(x)
  done

let draw_obstacles st h y =
  for x = 0 to 4 do
    Graphics.set_color Graphics.red;
    Graphics.draw_image st.images.trees
      (map check_x x_lst2).(x)
      (map check_y2 y_lst2).(x)
  done

let draw_rocks st h y =
  for x = 0 to 4 do
    Graphics.set_color (Graphics.rgb 102 204 0);
    Graphics.draw_image st.images.rocks
      (map check_x x_lst3).(x)
      (map check_y3 y_lst3).(x)
  done

let draw_score () =
  Graphics.moveto 750 800;
  text "Score: " 200 Graphics.black;
  Graphics.draw_string (string_of_int init.oompa.steps)

let draw_oompa st () =
  Graphics.draw_image st.images.oompa_loompa (fst init.oompa.location)
    (snd init.oompa.location)

let draw_collision () =
  Graphics.set_color Graphics.black;
  Graphics.draw_rect 100 100 50 50

let draw_background st () =
  draw_draw_obstacles st obstacle_lst 0;
  draw_obstacles st obstacle_lst 400;
  draw_rocks st rock_lst 600;
  draw_score ()

let rec update_car_1 st () =
  Graphics.set_color Graphics.black;
  Graphics.draw_image st.images.cars (fst init_car.location)
    (snd init_car.location);
  add_car init_car_list init_car;
  updateCar init_car init_car_list.hist_cars 1

let update_car_2 st () =
  Graphics.set_color Graphics.black;
  Graphics.draw_image st.images.cars (fst init_car_3.location)
    (snd init_car_3.location);
  add_car init_car_list init_car_3;
  move_car init_car_3 init_car_list.hist_cars 1;
  updateCar init_car_3 init_car_list.hist_cars 1

let update_car_3 st () =
  Graphics.set_color Graphics.black;
  Graphics.draw_image st.images.cars (fst init_car_2.location)
    (snd init_car_2.location);
  add_car init_car_list init_car_2;
  move_car init_car_2 init_car_list.hist_cars 1;
  updateCar init_car_2 init_car_list.hist_cars 1

let check_coll l cs = Characters.check_coll l cs

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

let reach_top (oompa : player) =
  if snd oompa.location > 850 then true else false

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
