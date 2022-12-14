(*Representation and rendering of Crossy Road - Oompa Loompa Version.

    This module primarily draws the map or game board for the game. This 
    includes the various screens that pop up (depending )





type color
type arrows
type input 
type t 
val text: string -> int -> int -> unit
val take_a_step: Characters.player -> unit
val create_issues_1 : Characters.obstacle list -> Characters.obstacle list 
val create_issues_2 : Characters.obstacle list -> Characters.obstacle list 
val create_issues_3 : Characters.obstacle list -> Characters.obstacle list 
val draw_draw_obstacles: Characters.obstacle  list -> int -> unit 
val draw_obstacles: Characters.obstacle list -> int -> unit 
val draw_rocks:Characters.obstacle list-> int -> unit 
val collision: Characters.player-> Characters.obstacle list-> bool
val move_oompa: Characters.player -> char -> 'a -> unit
val start: Characters.player-> Characters.obstacle list -> char -> State.t -> unit
val get_start_input: unit -> State.t -> unit
val get_moves : unit -> unit
*)