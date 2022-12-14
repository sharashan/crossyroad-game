(*Draws the background objects in the map*)
open Graphics
open Random

type background =
  | River
  | Road
  | Grass


type background_type = {
  back_type : background;
  location : int * int;
}

(*player width*)
let oompa_width = 50.

(*player height*)
let oompa_height  = 50.

let tree_width = 70.

let tree_height = 70.

let rock_width = 41.
(*tree width*)
let tree_width = 25.

(*tree height*)
let tree_height = 50.

(*rock width*)
let rock_width = 30.

(*rock height*)
let rock_height = 30.

(*[grass y] initializes grass with object_type Grass and location (0,y)*)
let grass y ={
  back_type = Grass; location = (0,y); 
}

(*[grass_draw x y] draws the grass at xy-coordinate (x,y)*)
let grass_draw x y = 
  Graphics.draw_rect x y 1000 150;
  Graphics.fill_rect x y 1000 150

(*[road_draw x y] draws the road at xy-coordinate (x,y)*)
let road_draw x y = 
  Graphics.draw_rect x y 1000 250;
  Graphics.fill_rect x y 1000 250

(*[water_draw x y] draws the water at xy-coordinate (x,y)*)
let water_draw x y = 
  Graphics.draw_rect x y 1000 200;
  Graphics.fill_rect x y 1000 200

  (*[tree_draw x y] draws the tree at xy-coordinate (x,y)*)
let tree_draw x y = 
  Graphics.moveto x y;
  Graphics.set_color Graphics.red
  (*Graphics.fill_rect (x) (y) 50 50*)

(*[background_crossy] calls on the draw helpers above to draw the grass, road,
   and water*)
  let background_crossy () = 
  (**GRASS*)
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 51 102 0);
  grass_draw 0 0;
  (**ROAD*) 
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 229 215 158);
  road_draw 0 150; 

  (**GRASS*)
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 51 102 0);
  grass_draw 0 400;
  (**WATER*) 
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 102 51 0);
  water_draw 0 550;
   
  (**ROAD*) 
   Graphics.moveto 0 0;
   Graphics.set_color (Graphics.rgb 229 215 158);
   road_draw 0 750; 
  






