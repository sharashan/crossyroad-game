type screen =
  | StartScreen
  | PlayScreen
  | PauseScreen

type t = {
  display : screen;
  mouse_pressed : bool;
  arrow_pressed : bool;
}

let init () =
  { display = StartScreen; mouse_pressed = false; arrow_pressed = false }

let change_screen s t = { t with display = s }
