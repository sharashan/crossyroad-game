(*Representation of the different states the game can be in. 

    This module outlines the different game modes, including start, play, pause
    and fail. Each of these states has a set of actions (and screens) associated
    with it that is displayed using this module.
    
*******************************************************************************)


(*The game_mode type consists of constructors for the various game states*)
type game_mode =
  | Start
  | Play
  | Pause
  | Fail
  | Win 

type images

(*The abstract type that represents the player's key and mouse inputs and a 
   mutable field game_state that represents which mode the game is in (this 
   has type game_mode)*)
type t = {
  mutable game_state : game_mode;
  mouse_pressed : bool;
  arrow_pressed : bool;
}


val text : string -> int -> int -> unit

(*[draw_start_screen] draws the start_screen when the record field game_state
   is set to Start. This displays text asking for an input to start the game*)
val draw_start_screen : unit -> unit

(*[draw_fail_screen] draws the fail_screen when the record field game_state
   is set to Fail. *)
val draw_fail_screen : unit -> unit

(*[draw_win_screen] draws the win_screen when the record field game_state
   is set to Win. *)
val draw_win_screen : unit -> unit

(*[draw_pause_screen] draws the pause_screen when the record field game_state
   is set to Pause. *)
val draw_pause_screen : unit -> unit

(*[string_to_state s] converts a given s to type game_mode. It is used in 
   [update_state s t]*)
val string_to_state : string -> game_mode

(*[update_state s t] changes the mutable record field game_state to whichever
   game mode [s] represents. [s] is a string that needs to be converted to type
   game_mode*)
val update_state : string -> t -> unit

(*[update_screen] checks the game state and executes the screen accordingly
   
For example, if game_state is equal to fail, it will draw the fail screen *)
val update_screen : 'a -> t -> unit -> unit
