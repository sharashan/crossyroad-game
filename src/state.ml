type game_mode =
  | Start
  | Play
  | Pause
  | Fail

type t = {
  display : game_mode;
  mouse_pressed : bool;
  arrow_pressed : bool;
}

let play_game init =
  if init.display = Start then init.display = Play else init.display = Fail

let change_screen s t = { t with display = s }
