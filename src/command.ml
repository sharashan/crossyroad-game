type move =
  | Up
  | Down
  | Left
  | Right

type t =
  | Move of move
  | Quit
  | Pause
