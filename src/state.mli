type play =
  | Start
  | Pause
  | Quit

type t

val get_score : t -> int
val update_score : t -> int
val update_state : string -> t -> unit
val get_coins : t -> int
val update_coins : t -> int
val get_state : t -> play
val set_state : t -> play

(*val draw_start_screen : unit -> unit *)
val set_start : unit -> unit
