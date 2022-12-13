open Graphics

(*Draws the background objects in the map*)
let grass = Graphics.draw_rect 0 0 1000 50
let log x y = Graphics.draw_rect x y 100 50
let water = Graphics.draw_rect 0 100 1000 50
let car x y = Graphics.draw_rect x y 50 50
