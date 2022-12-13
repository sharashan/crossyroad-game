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

(*Draws the background objects in the map*)
let grass y ={
  object_type = Grass; location = (0,y); 
}

let grass_draw x y = 
  Graphics.draw_rect x y 1000 150;
  Graphics.fill_rect x y 1000 150

let background_crossy () = 
  (**GRASS*)
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 102 204 0);
  grass_draw 0 0;
  (**ROAD*) 
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 96 96 96);
  Graphics.draw_rect 0 150 1000 250;
  Graphics.fill_rect 0 150 1000 250;
  (**GRASS*)
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 102 204 0);
  grass_draw 0 400;
  (**WATER*) 
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 102 178 255);
  Graphics.draw_rect 0 550 1000 200;
  Graphics.fill_rect 0 550 1000 200
