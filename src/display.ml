open Graphics
open Characters

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

(*let draw_oompa = Graphics.draw_rect (fst init.oompa.location) (snd
  init.oompa.location) 30 30*)

let text text size color =
  Graphics.set_color color;
  Graphics.draw_string text;
  Graphics.set_text_size size

let rec stats (frame : Graphics.status) =
  { key_pressed = frame.key; mouse_down = frame.button }

let move_oompa (oompa : player) new_input move_lst =
  match new_input with
  | 'a' ->
      oompa.location <-
        (if fst oompa.location - 10 > 0 then
         (fst oompa.location - 10, snd oompa.location)
        else oompa.location)
  | 'w' ->
      oompa.location <-
        (if snd oompa.location + 10 < 1000 then
         (fst oompa.location, snd oompa.location + 10)
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

let rec start () =
  Graphics.set_color Graphics.blue;
  Graphics.draw_rect (fst init.oompa.location) (snd init.oompa.location) 30 30;
  let input_2 = Graphics.read_key () in
  move_oompa init.oompa input_2 [];
  Graphics.moveto (fst init.oompa.location) (snd init.oompa.location);
  Graphics.clear_graph ();
  Graphics.draw_rect (fst init.oompa.location) (snd init.oompa.location) 30 30;
  Graphics.set_color Graphics.black;
  Graphics.draw_rect 100 100 50 50;
  start ()

let rec get_start_input () =
  let input = Graphics.read_key () in
  if input = 'a' then (
    Graphics.clear_graph ();
    Graphics.set_color Graphics.black;
    Graphics.draw_rect 100 100 50 50;
    start ())
  else (
    Graphics.clear_graph ();
    Graphics.moveto 400 420;
    text "Try Again" 500 Graphics.black;
    get_start_input ())

let draw_start_screen () =
  Graphics.draw_rect 200 200 600 500;
  Graphics.fill_rect 200 200 600 500;
  Graphics.moveto 320 420;
  Graphics.set_font "-*-fixed-medium-r-semicondensed--50-*-*-*-*-*-iso8859-1";
  text "Press A to start" 500 Graphics.white

let get_moves () =
  if Graphics.key_pressed () then
    Graphics.wait_next_event [ Graphics.Key_pressed ]
  else Graphics.wait_next_event [ Graphics.Poll ]
