open Image

type game_mode =
  | Start
  | Play
  | Pause
  | Fail
  | Win

type images = { oompa : Graphics.image }

type t = {
  mutable game_state : game_mode;
  mouse_pressed : bool;
  arrow_pressed : bool;
}

let init_images =
  { game_state = Start; mouse_pressed = false; arrow_pressed = false }

let text text size color =
  Graphics.set_color color;
  Graphics.draw_string text;
  Graphics.set_text_size size

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

let draw_win_screen () =
  Graphics.clear_graph ();
  Graphics.fill_rect 200 200 600 500;
  Graphics.draw_rect 200 200 600 500;
  Graphics.moveto 320 420;
  Graphics.set_font "-*-fixed-medium-r-semicondensed--50-*-*-*-*-*-iso8859-1";
  text "Noice! You won :)" 500 Graphics.white

let draw_pause_screen () =
  Graphics.clear_graph ();
  Graphics.draw_rect 200 200 600 500;
  Graphics.fill_rect 200 200 600 500;
  Graphics.moveto 320 420;
  Graphics.set_font "-*-fixed-medium-r-semicondensed--50-*-*-*-*-*-iso8859-1";
  text "The game is paused" 500 Graphics.white

let string_to_state = function
  | "start" -> Start
  | "play" -> Play
  | "pause" -> Pause
  | "fail" -> Fail
  | "win" -> Win
  | _ -> failwith "Not possible"

let update_state s t = t.game_state <- string_to_state s

let update_screen s t =
  if t.game_state = Fail then draw_fail_screen
  else if t.game_state = Pause then draw_pause_screen
  else failwith "You suck!"
