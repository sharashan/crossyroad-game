(*Accumulation of all the constants used in the implementing the game.

    This module defines the constants that are used multiple times when 
    implementing the game.
    
*******************************************************************************)

(*The background type defines elements in the background of the game board*)
type background =
  | River
  | Road
  | Grass

(*The background_type is a record that has fields object_type (which is of 
   type background) and location*)
type background_type = {
  back_type : background;
  location : int * int;
}

(*[oompa_width] is the width of the main player*)
val oompa_width : float

(*[oompa_height] is the height of the main player*)
val oompa_height : float

(*[tree_width] is the width of a tree*)
val tree_width : float

(*[tree_height] is the height of a tree*)
val tree_height : float

(*[rock_width] is the width of a rock*)
val rock_width : float

(*[rock_height] is the height of a rock*)
val rock_height : float

(*[grass y] initializes grass with object_type Grass and location (0,y)*)
val grass : int -> background_type

(*[grass_draw x y] draws the grass at xy-coordinate (x,y)*)
val grass_draw : int -> int -> unit

(*[road_draw x y] draws the road at xy-coordinate (x,y)*)
val road_draw : int -> int -> unit

(*[water_draw x y] draws the water at xy-coordinate (x,y)*)
val water_draw : int -> int -> unit

(*[tree_draw x y] draws the tree at xy-coordinate (x,y)*)
val tree_draw : int -> int -> unit

(*[background_crossy] calls on the draw helpers above to draw the grass, road,
   and water*)
val background_crossy : unit -> unit
