type state =
  | Start
  | Pause
  | Quit

type t

val get_score : t -> int
val update_score : t -> int
val get_coins : t -> int
val update_coins : t -> int
val get_state : t -> state
val set_state : t -> state
