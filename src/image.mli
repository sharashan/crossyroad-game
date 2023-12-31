(** Representation of png images as files compatible with the OCaml Graphics
    module

    This module allows imported png images to be used to depict characters, such
    as the oompa loompa, or the cotton candy trees, etc. *)

(******************************************************************************)

(** this is based off of the original source code of camlimages. The link to the
    source:
    https://gitlab.com/camlspotter/camlimages/-/blob/hg-b4.2.6/src/graphic_image.ml *)

val array_of_image : Images.t -> int -> int -> int -> int array array
(** [array_of_image] converts the image into an a color matrix. *)

val of_image : Images.t -> int -> int -> int -> Graphics.image
(** [of_image] uses the Graphics function [make_image] to convert the color
    matrix into an image that is compatible with Graphics. *)

val draw_image : int -> int -> Images.t -> int -> int -> int -> unit
(** [draw_image] draws the image that [of_image] returns. *)
