open Graphics

(** Draws the sprites and the background*)

type input = {
  key_pressed : char;
  mouse_down : bool;
}

val text : string -> int -> Graphics.color -> unit
(** [text str s] draws the text str with size s*)

val stats : Graphics.status -> input
val get_start_input : unit -> unit
(*val draw_start_screen : unit -> unit *)