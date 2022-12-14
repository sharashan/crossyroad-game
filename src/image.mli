(** Representation of png images as files compatible with the OCaml Graphics
    module

    This module allows imported png images to be used to depict characters, such
    as the oompa loompa, or the cotton candy trees, etc. *)

(******************************************************************************)

(** this is based off of the original source code of camlimages. The link to the
    source:
    https://gitlab.com/camlspotter/camlimages/-/blob/hg-b4.2.6/src/graphic_image.ml *)

<<<<<<< HEAD
val array_of_image : 'a -> 'b -> 'c -> 'd -> 'e
(*[array_of_image] converts the image into an a color matrix. *)
=======
val array_of_image : 'a -> 'b -> 'c -> 'd -> 'weak938
(** [array_of_image] converts the image into an a color matrix. *)
>>>>>>> 3caa3193902e395d9ca613b2018db666120a65de

val of_image : 'a -> 'b -> 'c -> 'd -> 'e
(** [of_image] uses the Graphics function [make_image] to convert the color
    matrix into an image that is compatible with Graphics. *)

val draw_image : int -> int -> 'a -> 'b -> 'c -> 'd -> 'e
(** [draw_image] draws the image that [of_image] returns. *)
