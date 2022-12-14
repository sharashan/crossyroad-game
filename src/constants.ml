(*Draws the background objects in the map*)
open Graphics
open Random

type background =
  | River
  | Road
  | Grass


type background_type = {
  object_type : background;
  location : int * int;
}

let oompa_width = 50.

let oompa_height  = 50.

let tree_width = 50.

let tree_height = 50.

let rock_width = 30.

let rock_height = 30.

let grass y ={
  object_type = Grass; location = (0,y); 
}

let grass_draw x y = 
  Graphics.draw_rect x y 1000 150;
  Graphics.fill_rect x y 1000 150

let road_draw x y = 
  Graphics.draw_rect x y 1000 250;
  Graphics.fill_rect x y 1000 250

let water_draw x y = 
  Graphics.draw_rect x y 1000 200;
  Graphics.fill_rect x y 1000 200

let tree_draw x y = 
  Graphics.moveto x y;
  Graphics.set_color Graphics.red; 
  Graphics.fill_rect (x) (y) 50 50

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
  





  


