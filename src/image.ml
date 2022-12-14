(*open Graphics open Images open Camlimages

  let array_of_image img = match img with | Rgb24 bitemap -> let w =
  bitmap.Rgb24.rock_width and h = bitmap.Rgb24.height in Array.init h (fun i ->
  Array.init w (fun j -> let { r; g; b } = Rgb.unsafe_get bitmap j i in rgb r g
  b)) | _ -> failwith "Not supported"

  let of_image img = Graphics.make_image (array_of_image img) let draw_image img
  x y = Graphics.draw_image (of_image img)*)
