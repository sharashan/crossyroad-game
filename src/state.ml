type game_mode =
  | Start
  | Play
  | Pause
  | Fail

type t = {
  mutable game_state : game_mode;
  mouse_pressed : bool;
  arrow_pressed : bool;
}

let text text size color =
  Graphics.set_color color;
  Graphics.draw_string text;
  Graphics.set_text_size size

(*let play_game init = if init.game_state = Start then init.game_state = Play
  else init.game_state = Fail *)

let draw_start_screen () =
  Graphics.draw_rect 200 200 600 500;
  Graphics.fill_rect 200 200 600 500;
  Graphics.moveto 320 420;
  Graphics.set_font "-*-fixed-medium-r-semicondensed--50-*-*-*-*-*-iso8859-1";
  text "Press A to start" 500 Graphics.white

let draw_fail_screen () =
  Graphics.clear_graph ();
  Graphics.fill_rect 200 200 600 500;
  Graphics.draw_rect 200 200 600 500;
  Graphics.moveto 320 420;
  Graphics.set_font "-*-fixed-medium-r-semicondensed--50-*-*-*-*-*-iso8859-1";
  text "lmaoo You Lost :(" 500 Graphics.white

let draw_pause_screen () =
  Graphics.clear_graph ();
  Graphics.draw_rect 200 200 600 500;
  Graphics.fill_rect 200 200 600 500;
  Graphics.moveto 320 420;
  Graphics.set_font "-*-fixed-medium-r-semicondensed--50-*-*-*-*-*-iso8859-1";
  text "The game is paused" 500 Graphics.white

(*let change_screen s t = { t with game_state = s } *)

let string_to_state = function
  | "start" -> Start
  | "play" -> Play
  | "pause" -> Pause
  | "fail" -> Fail
  | _ -> failwith "Not possible"

let update_state s t = t.game_state <- string_to_state s

(*let start_to_play s t = if t.game_state = Start then Display.get_start_input
  (); update_state "play"

  let set_start t = update_state "start"; start_to_play "play"*)

let update_screen s t =
  if t.game_state = Fail then Display.draw_fail_screen
  else if t.game_state = Pause then draw_pause_screen
  else failwith "You suck!"
