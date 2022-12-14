open Graphics
open Camlimages
open Images

let array_of_image img r g b =
  match img with
  | Rgba32 bitmap ->
      let width = bitmap.Rgba32.width and height = bitmap.Rgba32.height in
      Array.init height (fun l ->
          Array.init width (fun m ->
              let ({ color; alpha } : rgba) = Rgba32.unsafe_get bitmap m l in
              let { r; b; g } = color in
              match (r, b, g, alpha) with
              | r, g, b, 0 -> rgb red green blue
              | r, g, b, a -> rgb r g b))
  | _ -> failwith "Filetype not supported"

let of_image img red blue green =
  Graphics.make_image (array_of_image img red blue green)

let draw_image (x : int) (y : int) img red blue green =
  Graphics.draw_image (of_image img red blue green) x y
