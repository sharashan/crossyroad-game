type input_recieved = {
  key_pressed : char;
  mouse_pressed : bool;
}

type t = {
  key_current : char;
  steps : int;
}

let starting_input () = { key_current = Char.chr 0; steps = 0 }

let new_frame (frame : Graphics.status) =
  { key_pressed = frame.key; mouse_pressed = frame.button }

let get_input () =
  if Graphics.key_pressed () then
    Graphics.wait_next_event [ Graphics.Key_pressed ]
  else Graphics.wait_next_event [ Graphics.Poll ]
