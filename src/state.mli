(*Representation and rendering of Crossy Road - Oompa Loompa Version.

    This module primarily draws the map or game board for the game. This 
    includes the various screens that pop up (depending on state changes), the
    main character, and the obstacles designed to make the game harder (e.g. 
    rocks, trees, etc.). In addition, it also draws background elements, like 
    water, grass, the road, and also keeps track of the score of the player
    
*******************************************************************************)

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

val text : string -> int -> int -> unit
val draw_start_screen : unit -> unit
val draw_fail_screen : unit -> unit
val draw_pause_screen : unit -> unit
val string_to_state : string -> game_mode
val update_state : string -> t -> unit
val update_screen : 'a -> t -> unit -> unit
