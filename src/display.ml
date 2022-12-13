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

type t = {
  key_press : char;
  moves_list : input list;
}

type init = { mutable oompa : player }
type init2 = { mutable obstacle : player }

let init = { oompa = { location = (50, 50); speed = 0; frame = 0; steps = 0 } }

let init2 =
  { obstacle = { location = (100, 100); speed = 0; frame = 0; steps = 0 } }

let obstacle_lst = [ init2 ]

(*let draw_oompa = Graphics.draw_rect (fst init.oompa.location) (snd
  init.oompa.location) 30 30*)

let text text size color =
  Graphics.set_color color;
  Graphics.draw_string text;
  Graphics.set_text_size size

let rec stats (frame : Graphics.status) =
  { key_pressed = frame.key; mouse_down = frame.button }

let take_a_step (oompa : player) = oompa.steps <- oompa.steps + 1

let rec collision (oompa : player) (obstacle_lst : init2 list) =
  match obstacle_lst with
  | [] -> false
  | h :: t ->
      if
        abs (fst h.obstacle.location - fst oompa.location) <= (16 / 2) + (36 / 2)
        && abs (snd h.obstacle.location - snd oompa.location)
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

let draw_fail_screen () =
  Graphics.clear_graph ();
  Graphics.fill_rect 200 200 600 500;
  Graphics.draw_rect 200 200 600 500;
  Graphics.moveto 320 420;
  Graphics.set_font "-*-fixed-medium-r-semicondensed--50-*-*-*-*-*-iso8859-1";
  text "lmaoo You Lost :(" 500 Graphics.white

(*let background_crossy () = 
  (**GRASS*)
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 102 204 0);
  Graphics.draw_rect 0 0 1000 150;
  Graphics.fill_rect 0 0 1000 150;
  (**ROAD*) 
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 96 96 96);
  Graphics.draw_rect 0 150 1000 250;
  Graphics.fill_rect 0 150 1000 250;
  (**GRASS*)
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 102 204 0);
  Graphics.draw_rect 0 400 1000 150;
  Graphics.fill_rect 0 400 1000 150;
  (**WATER*) 
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 102 178 255);
  Graphics.draw_rect 0 550 1000 200;
  Graphics.fill_rect 0 550 1000 200*)

let rec start (oompa : player) lst =
  Constants.background_crossy (); 
  (**UPDATE SCORE*)
  Graphics.moveto 800 800;
  text "Score: " 200 Graphics.black;
  Graphics.draw_string (string_of_int init.oompa.steps);
  (**OBSTACLE*)
  Graphics.set_color Graphics.black;
  Graphics.draw_rect 100 100 50 50;
  (**OOMPA*)
  Graphics.set_color Graphics.blue;
  Graphics.draw_rect (fst init.oompa.location) (snd init.oompa.location) 30 30;
  let input_2 = Graphics.read_key () in
  move_oompa init.oompa input_2 [];
  Graphics.moveto (fst init.oompa.location) (snd init.oompa.location);
  Graphics.clear_graph ();
  (**REDRAW GRAPHICS*)
  Graphics.draw_rect (fst init.oompa.location) (snd init.oompa.location) 30 30;
  Graphics.set_color Graphics.black;
  Graphics.draw_rect 100 100 50 50;
  if collision oompa lst then draw_fail_screen () else start oompa lst

let rec get_start_input () =
  let input = Graphics.read_key () in
  if input = 'a' then (
    Graphics.clear_graph ();
    Graphics.set_color Graphics.black;
    Graphics.draw_rect 100 100 50 50;
   (** Graphics.moveto 750 720;
    text "Score: " 150 Graphics.black;
    Graphics.draw_string (string_of_int init.oompa.steps);**)
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
