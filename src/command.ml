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

let handle_event_init (st : State.t) =
  let p = Graphics.wait_next_event [ Graphics.Poll ] in
  Graphics.clear_graph ();
  Graphics.moveto 0 0;
  p

(*let handle_event_draw (st:State.t) events = match st.screen with
  |Screen.StartScreen -> Screen_start.draw st events |Screen.PlayScreen ->
  Screen_play.draw st events |Screen.PauseScreen -> Screen_pause.draw st events
  |Screen.FailScreen -> Screen_fail draw st events

  let handle_event_tick (st :State.t) = match st.screen with |Screen.StartScreen
  -> Screen_start.tick st |Screen.PlayScreen -> Screen_play.tick st
  |Screen.PauseScreen -> Screen_pause.tick st |Screen.FailScreen ->
  Screen_fail.draw st

  let rec handle_event (st:State.t) = let he = handle_event st in (*init event
  handlers*) let ev = Events.make (Graphics.mouse_pos ()) in handle_event_draw
  st events; Graphics.synchronize (); let real_time = Unix.gettimeofday () in
  let should_tick = real_time -. st.real_last_tick_time > 1./.30. in let st = if
  should_tick then handle_event_tick st else st in let st = if e.button &&
  st.was_mouse_pressed then Events.handle_click st events else st in let st =
  {st with was_mouse_pressed = he.button } in if should_tick then
  st.real_last_tick_time <- real_time; handle_event st

  let launch (st : unit -> State.t) = Graphics.open_graph "";
  Graphics.set_window_title "Crossy Road"; Graphics.auto_synchronize false;
  handle_event (st ()) *)
