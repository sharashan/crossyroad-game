open Graphics
open ANSITerminal
open Crossyroad

type init = { mutable g_state : State.t }

let init =
  {
    g_state =
      { game_state = Start; mouse_pressed = false; arrow_pressed = false };
  }

let rec play_game () : unit =
  ANSITerminal.(
    print_string [ white ] "\nWelcome to the Crossy Road: Oomp Ver!\n");
  ANSITerminal.(print_string [ white ] "\nPress 0 or enter zero to start. \n> ");
  let input = read_line () in
  if input = "0" || input = "zero" then (
    Graphics.open_graph " 1000x1000";
    State.draw_start_screen ();
    State.update_state "start" init.g_state;
    Display.get_start_input ();
    State.update_state "play" init.g_state;
    ignore (Graphics.read_key ()))
  else (
    ANSITerminal.(print_string [ white ] "\nTry again!\n");
    play_game ())

let () = play_game ()