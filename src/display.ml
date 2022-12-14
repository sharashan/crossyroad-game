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

let init = { oompa = { location = (50, 50); speed = 0; frame = 0; steps = 0; oompa_width = 30; oompa_height = 30 } }

let init2 =
  { obstacle = {object_type = Tree; location = (100, 100)}}

let init3 = {rock = {object_type = Rock; location = (100,650)}}

let init_car = car Car 0 250 0 30 0 Right 
let init_car_2 = car Car 750 300 0 30 0 Left 

let init_car_3 = car Car 750 800 0 30 0 Left 

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

let rec stats (frame : Graphics.status) =
  { key_pressed = frame.key; mouse_down = frame.button }

let take_a_step (oompa : player) = oompa.steps <- oompa.steps + 1

let rec print_list (lst:obstacle list)= 
  match lst with 
  |[]-> () 
  | h ::t -> print_endline (string_of_int (fst h.location)); print_string " "; print_list t

let create_issues_2 lst =
  match lst with 
  |[]->  (pain_init 400).trees :: [] 
  | h :: t -> (pain_init 400).trees :: h :: t 

let create_issues_1 lst =
  match lst with 
  |[]->  (pain_init 0).trees :: [] 
  | h :: t -> (pain_init 0).trees :: h :: t 

  let create_issues_3 lst =
    match lst with 
    |[]->  rock_init.rocks :: [] 
    | h :: t -> rock_init.rocks :: h :: t 

  let x_lst = [|Random.int 1000; Random.int 1000;Random.int 1000;Random.int 1000
  ;Random.int 1000;Random.int 1000; Random.int 1000;Random.int 1000;
  Random.int 1000;Random.int 1000;Random.int 1000; Random.int 1000;
  Random.int 1000;Random.int 1000;Random.int 1000|]
  let y_lst = [|Random.int 150 - 25; Random.int 150 - 25;Random.int 150 - 25;
  Random.int 150 - 25;Random.int 150 - 25;Random.int 150 - 25; 
  Random.int 150 - 25;Random.int 150 - 25;Random.int 150 - 25;
  Random.int 150 - 25;Random.int 200 - 15;Random.int 200 - 15;
  Random.int 200 - 15;Random.int 200 - 15;Random.int 200 - 15|]

let draw_draw_obstacles (h) y = 
  for x = 0 to 4 do (
  Graphics.set_color Graphics.red; 
  Graphics.fill_rect (x_lst.(x)) ((y_lst.(x))) 50 50;) done

(*let spawn_car  = 
  let new_car = Characters.spawn_moving_ob 200 Car in
  init_row.cars <- new_car :: init_row.cars*)

let draw_obstacles h y = 
  for x = 5 to 9 do (
    Graphics.set_color Graphics.red; 
    Graphics.fill_rect (x_lst.(x)) ((y_lst.(x))+y) 50 50;) done

let draw_rocks h y = 
  for x = 10 to 14 do (
    Graphics.set_color (Graphics.rgb 102 204 0) ; 
    Graphics.fill_rect (x_lst.(x)) ((y_lst.(x))+y) 30 30;) done

let draw_score () = 
  Graphics.moveto 800 800;
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
  Graphics.set_color Graphics.white;
  Graphics.draw_rect (fst init_car.location)(snd init_car.location) car_width car_height; 
  add_car init_car_list init_car;
  add_car init_car_list init_car_2;
  updateCar init_car init_car_list.hist_cars 5 

let update_car_2 () = 
  Graphics.set_color Graphics.white;
  Graphics.draw_rect (fst init_car.location)(snd init_car.location) car_width car_height; 
  add_car init_car_list init_car_3;
  updateCar init_car init_car_list.hist_cars 5

let rec collision (oompa : player) (lst)=
  match obstacle_lst with
  | [] -> false
  | h :: t ->
      if
        abs (x_lst.(0) - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (y_lst.(0) - snd oompa.location)
           <= (16 / 2) + (36 / 2)
      then true
      else if 
        abs (x_lst.(1) - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (y_lst.(1) - snd oompa.location)
        <= (16 / 2) + (36 / 2)
      then true
      else if abs (x_lst.(2) - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (y_lst.(2) - snd oompa.location)
        <= (16 / 2) + (36 / 2)
      then true
      else if abs (x_lst.(3) - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (y_lst.(3) - snd oompa.location)
        <= (16 / 2) + (36 / 2)
        then true
      else if abs (x_lst.(4) - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (y_lst.(4) - snd oompa.location)
        <= (16 / 2) + (36 / 2)
      then true
else if abs (x_lst.(5) - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (y_lst.(5)+400 - snd oompa.location)
           <= (16 / 2) + (36 / 2)
      then true
      else if 
        abs (x_lst.(6) - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (y_lst.(6)+400 - snd oompa.location)
        <= (16 / 2) + (36 / 2)
      then true
      else if abs (x_lst.(7) - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (y_lst.(7)+400 - snd oompa.location)
        <= (16 / 2) + (36 / 2)
      then true
      else if abs (x_lst.(8) - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (y_lst.(8)+400 - snd oompa.location)
        <= (16 / 2) + (36 / 2)
        then true
      else if abs (x_lst.(9) - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (y_lst.(9)+400 - snd oompa.location)
        <= (16 / 2) + (36 / 2)
      then true
    else if abs (x_lst.(10) - fst oompa.location) <= (16 / 2) + (36 / 2)
      && abs (y_lst.(10)+600 - snd oompa.location)
         <= (16 / 2) + (36 / 2)
    then true
    else if 
      abs (x_lst.(11) - fst oompa.location) <= (16 / 2) + (36 / 2)
      && abs (y_lst.(11)+600 - snd oompa.location)
      <= (16 / 2) + (36 / 2)
    then true
    else if abs (x_lst.(12) - fst oompa.location) <= (16 / 2) + (36 / 2)
      && abs (y_lst.(12)+600 - snd oompa.location)
      <= (16 / 2) + (36 / 2)
    then true
    else if abs (x_lst.(13) - fst oompa.location) <= (16 / 2) + (36 / 2)
      && abs (y_lst.(13)+600 - snd oompa.location)
      <= (16 / 2) + (36 / 2)
      then true
    else if abs (x_lst.(14) - fst oompa.location) <= (16 / 2) + (36 / 2)
      && abs (y_lst.(14)+600 - snd oompa.location)
      <= (16 / 2) + (36 / 2)
    then true
      else false && collision oompa t

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

(**let tick init (st :State.t) = 
  st.timer <- st.timer + 1; 
  List.iter (fun row -> row.cars |> List.iter Characters.car_walk_n)**)

let rec start (oompa : player) (lst:obstacle list) =
  Constants.background_crossy (); 
  update_car (); 
  update_car_2(); 
  draw_draw_obstacles obstacle_lst 0;
  draw_obstacles obstacle_lst 400;
  draw_rocks rock_lst 600;
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
  if collision oompa obstacle_lst then (State.draw_fail_screen ();
   State.update_state "fail";) else start oompa lst

let rec get_start_input () =
  let input = Graphics.read_key () in
  if input = 'a' then (
    Graphics.clear_graph ();
    Graphics.set_color Graphics.black;
    Graphics.draw_rect 100 100 50 50;
   (** Graphics.moveto 750 720;
    text "Score: " 150 Graphics.black;
    Graphics.draw_string (string_of_int init.oompa.steps);**)
    tick init_t;
    start init.oompa obstacle_lst)
  else (
    Graphics.clear_graph ();
    Graphics.moveto 400 420;
    text "Try Again" 500 Graphics.black;
    get_start_input ())

let get_moves () =
  if Graphics.key_pressed () then
    Graphics.wait_next_event [ Graphics.Key_pressed ]
  else Graphics.wait_next_event [ Graphics.Poll ]
