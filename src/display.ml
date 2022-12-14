open Graphics
open Characters
open Constants

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

type row = {
  mutable cars : moving_ob list; 
}
let init_row = { cars = []; }

type t = {
  key_press : char;
  moves_list : input list;
}

type init = { mutable oompa : player }
type init2 = { mutable obstacle : obstacle }
type init3 = {mutable rock: obstacle}

let _ = Random.self_init()

let init = { oompa = { location = (500, 30); speed = 0; frame = 0; steps = 0; oompa_width = 30; oompa_height = 30 } }

let init2 =
  { obstacle = {object_type = Tree; location = (100, 100)}}

let init3 = {rock = {object_type = Rock; location = (100,650)}}

let init_car = car Car 0 150 0 10 0 Right 
let init_car_2 = car Car 100 300 0 10 0 Left 

let init_car_3 = car Car 300 800 0 10 0 Left 

let move_lst = [init_car; init_car_2]

let init_t = { oompa = init.oompa; characters_moving = move_lst; state = Play}

let init_car_list = {hist_cars = []}

type pain_init = {trees : obstacle}  

type rock_init = {rocks: obstacle}

let pain_init (y : int) =
  { trees = {object_type = Tree; location = (Random.int 1000, Random.int 150 + y) }}

let rock_init = 
  {rocks = {object_type = Rock; location = (Random.int 1000, Random.int 150)}}

let obstacle_lst =  [init2.obstacle]

let rock_lst = [init3.rock]

let text text size color =
  Graphics.set_color color;
  Graphics.draw_string text;
  Graphics.set_text_size size

let take_a_step (oompa : player) = oompa.steps <- oompa.steps + 1

let rec print_list (lst:obstacle list)= 
  match lst with 
  |[]-> () 
  | h ::t -> print_endline (string_of_int (fst h.location)); print_string " "; print_list t

let create_issues_1 lst =
  match lst with 
  |[]->  (pain_init 0).trees :: [] 
  | h :: t -> (pain_init 0).trees :: h :: t 

let create_issues_2 lst =
  match lst with 
  |[]->  (pain_init 400).trees :: [] 
  | h :: t -> (pain_init 400).trees :: h :: t 

  let create_issues_3 lst =
    match lst with 
    |[]->  rock_init.rocks :: [] 
    | h :: t -> rock_init.rocks :: h :: t 

  let tree_h_int = int_of_float Constants.tree_height
  let rock_h_int = int_of_float Constants.rock_height
  let tree_w_int = int_of_float Constants.tree_width
  let rock_w_int = int_of_float Constants.rock_width

  let x_lst = [|Random.int 1000; Random.int 1000;Random.int 1000;Random.int 1000; Random.int 1000|]
  
  let x_lst2 = [|Random.int 1000; Random.int 1000;Random.int 1000;
  Random.int 1000;Random.int 1000|]

  let x_lst3 = [|Random.int 1000; Random.int 1000;
  Random.int 1000;Random.int 1000;Random.int 1000|]

  let check_x x = 
    if x < 100 then x + 50 
    else if x > 900 then  x - 50
    else if x = 50 then x + 50
    else x 

  let map f lst = Array.map f lst

  let y_lst = [|Random.int 140 +10; Random.int 140 + 10;Random.int 140 + 10;
  Random.int 140 + 10;Random.int 140 + 10|]

  let y_lst2 = [|Random.int 550; 
  Random.int 550;Random.int 550;Random.int 550;
  Random.int 550|]

  let y_lst3 = [|Random.int 750 ;Random.int 750 ;
  Random.int 750 ;Random.int 750 ;Random.int 750 |]

  let check_y1 x = 
    if x < 50 then x + 50 
    else if x >= 100 then  x - 50
    else if x = 50 then x + 50
    else x 

   let check_y2 x = 
    if x < 100 then x + 400 
    else if x < 200 then x + 300
    else if x < 300 then x + 200
   else if x < 400 then x + 100
    else if x >= 500 then  x - 50
    else x 

  let check_y3 x = 
    if x < 100 then x + 600 
    else if x < 200 then x + 500
    else if x < 300 then x + 400
   else if x < 400 then x + 300
   else if x < 500 then x + 200
   else if x < 600 then x + 100
    else if x >= 700 then  x - 50
    else x 

let draw_draw_obstacles h y = 
          for x = 0 to 4 do (
            Graphics.set_color Graphics.red; 
            Graphics.fill_rect ((map check_x x_lst).(x)) ((map check_y1 y_lst).(x)) tree_w_int tree_h_int;) done
    

let draw_obstacles h y = 
  for x = 0 to 4 do (
    Graphics.set_color Graphics.red; 
    Graphics.fill_rect ((map check_x x_lst2).(x)) ((map check_y2 y_lst2).(x)) tree_w_int tree_h_int;) done

let draw_rocks h y = 
  for x = 0 to 4 do (
    Graphics.set_color (Graphics.rgb 102 204 0) ; 
    Graphics.fill_rect ((map check_x x_lst3).(x)) ((map check_y3 y_lst3).(x)) rock_w_int rock_h_int;) done 

let draw_score () = 
  Graphics.moveto 750 800;
  text "Score: " 200 Graphics.black;
  Graphics.draw_string (string_of_int init.oompa.steps)

let draw_oompa () = 
  Graphics.set_color Graphics.blue;
  Graphics.draw_rect (fst init.oompa.location) (snd init.oompa.location) 30 30

let draw_collision () = 
  Graphics.set_color Graphics.black;
  Graphics.draw_rect 100 100 50 50

let draw_background () = 
  draw_draw_obstacles obstacle_lst 0;
  draw_obstacles obstacle_lst 400;
  draw_rocks rock_lst 600;
  (**UPDATE SCORE*)
  draw_score ()

let rec update_car () = 
  Graphics.set_color Graphics.black;
  Graphics.draw_rect (fst init_car.location)(snd init_car.location) car_width car_height; 
  add_car init_car_list init_car;
  add_car init_car_list init_car_2;
  updateCar init_car init_car_list.hist_cars 2 

let update_car_2 () = 
  Graphics.set_color Graphics.black;
  Graphics.draw_rect (fst init_car_3.location)(snd init_car_3.location) car_width car_height; 
  add_car init_car_list init_car_3;
  move_car init_car_3 init_car_list.hist_cars 1; 
  updateCar init_car_3 init_car_list.hist_cars 1

let update_car_3 () = 
  Graphics.set_color Graphics.black;
  Graphics.draw_rect (fst init_car_2.location)(snd init_car_2.location) car_width car_height; 
  add_car init_car_list init_car_2;
  move_car init_car_2 init_car_list.hist_cars 1; 
  updateCar init_car_2 init_car_list.hist_cars 1

let check_coll l cs = Characters.check_coll l cs 

let rec collision_car (oompa:player) (car: moving_ob) (hist_lst:moving_ob list)= 
  match hist_lst with 
  |[] -> false
  |h::t -> (if abs (fst oompa.location - fst car.location) <= (car_width)/2 + 15 && abs 
    (snd oompa.location - snd car.location) <= (car_width)/2 + 15
    then true
else false && collision_car oompa h t) 

let rec collision (oompa : player) (lst)=
  match obstacle_lst with
  | [] -> false
  | h :: t ->
      if
        abs ((map check_x x_lst).(0) - fst oompa.location) <= (init.oompa.oompa_width/ 2) + (tree_w_int/ 2)
        && abs ((map check_y1 y_lst).(0) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if 
        abs ((map check_x x_lst).(1) - fst oompa.location) <= (init.oompa.oompa_width/ 2) + (tree_w_int/ 2)
        && abs ((map check_y1 y_lst).(1) - snd oompa.location)
        <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if abs ((map check_x x_lst).(2) - fst oompa.location) <= (init.oompa.oompa_width/ 2) + (tree_w_int/ 2)
        && abs ((map check_y1 y_lst).(2) - snd oompa.location)
        <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if abs ((map check_x x_lst).(3) - fst oompa.location) <= (init.oompa.oompa_width/ 2) + (tree_w_int/ 2)
        && abs ((map check_y1 y_lst).(3) - snd oompa.location)
        <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
        then true
      else if abs ((map check_x x_lst).(4) - fst oompa.location) <= (init.oompa.oompa_width/ 2) + (tree_w_int/ 2)
        && abs ((map check_y1 y_lst).(4) - snd oompa.location)
        <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if abs ((map check_x x_lst2).(0) - fst oompa.location) <= (init.oompa.oompa_width/ 2) + (tree_w_int/ 2)
        && abs ((map check_y2 y_lst2).(0) - snd oompa.location)
           <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if 
        abs ((map check_x x_lst2).(1) - fst oompa.location) <= (init.oompa.oompa_width/ 2) + (tree_w_int/ 2)
        && abs ((map check_y2 y_lst2).(1) - snd oompa.location)
        <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if abs ((map check_x x_lst2).(2) - fst oompa.location) <= (init.oompa.oompa_width/ 2) + (tree_w_int/ 2)
        && abs ((map check_y2 y_lst2).(2) - snd oompa.location)
        <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      else if abs ((map check_x x_lst2).(3) - fst oompa.location) <= (init.oompa.oompa_width/ 2) + (tree_w_int/ 2)
        && abs ((map check_y2 y_lst2).(3) - snd oompa.location)
        <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
        then true
      else if abs ((map check_x x_lst2).(4) - fst oompa.location) <= (init.oompa.oompa_width/ 2) + (tree_w_int/ 2)
        && abs ((map check_y2 y_lst2).(4) - snd oompa.location)
        <= (init.oompa.oompa_height / 2) + (tree_h_int / 2)
      then true
      
    else if abs ((map check_x x_lst3).(0) - fst oompa.location) <= (init.oompa.oompa_width / 2) + (rock_w_int / 2)
      && abs ((map check_y3 y_lst3).(0) - snd oompa.location)
         <= (init.oompa.oompa_height / 2) + (rock_h_int / 2)
    then true
    else if 
      abs ((map check_x x_lst3).(1) - fst oompa.location) <= (init.oompa.oompa_width / 2) + (rock_w_int / 2)
      && abs ((map check_y3 y_lst3).(1)- snd oompa.location)
      <= (init.oompa.oompa_height / 2) + (rock_h_int / 2)
    then true
    else if abs ((map check_x x_lst3).(2) - fst oompa.location) <= (init.oompa.oompa_width / 2) + (rock_w_int / 2)
      && abs ((map check_y3 y_lst3).(2) - snd oompa.location)
      <= (init.oompa.oompa_height / 2) + (rock_h_int / 2)
    then true
    else if abs ((map check_x x_lst3).(3) - fst oompa.location) <= (init.oompa.oompa_width / 2) + (rock_w_int / 2)
      && abs ((map check_y3 y_lst3).(3) - snd oompa.location)
      <= (init.oompa.oompa_height / 2) + (rock_h_int / 2)
      then true
    else if abs ((map check_x x_lst3).(4) - fst oompa.location) <= (init.oompa.oompa_width / 2) + (rock_w_int / 2)
      && abs ((map check_y3 y_lst3).(4)- snd oompa.location)
      <= (init.oompa.oompa_height / 2) + (rock_h_int / 2)
    then true 
      else false && collision oompa t

let reach_top (oompa:player) = if snd oompa.location > 850 then true else false

let move_oompa (oompa : player) new_input move_lst =
  match new_input with
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

let rec start (oompa : player) (lst:obstacle list) =
  Constants.background_crossy (); 
  update_car (); 
  update_car_2(); 
  update_car_3();
  draw_draw_obstacles obstacle_lst 0;
  draw_obstacles obstacle_lst 0;
  draw_rocks rock_lst 0; 
  (**UPDATE SCORE*)
  draw_score ();
  (**OOMPA*)
  draw_oompa (); 
  let input_2 = Graphics.read_key () in
  move_oompa init.oompa input_2 [];
  Graphics.moveto (fst init.oompa.location) (snd init.oompa.location);
  Graphics.clear_graph ();
  (**REDRAW GRAPHICS*)
  draw_oompa ();
  if collision oompa obstacle_lst || collision_car oompa init_car init_car_list.hist_cars || collision_car oompa init_car_3 init_car_list.hist_cars || collision_car oompa init_car_2 init_car_list.hist_cars then (State.draw_fail_screen ();   State.update_state "fail";) else if reach_top oompa then (State.draw_win_screen (); 
   State.update_state "win";)
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

