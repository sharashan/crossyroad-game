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


let background_crossy () = 
  (**GRASS*)
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 102 204 0);
  Graphics.draw_rect 0 0 1000 150;
  Graphics.fill_rect 0 0 1000 150;
  (**ROAD*) 
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 96 96 96);
  Graphics.draw_rect 0 150 1000 250;
  Graphics.fill_rect 0 150 1000 250;
  (**GRASS*)
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 102 204 0);
  Graphics.draw_rect 0 400 1000 150;
  Graphics.fill_rect 0 400 1000 150;
  (**WATER*) 
  Graphics.moveto 0 0;
  Graphics.set_color (Graphics.rgb 102 178 255);
  Graphics.draw_rect 0 550 1000 200;
  Graphics.fill_rect 0 550 1000 200
