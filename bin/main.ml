open Graphics
open ANSITerminal
open Crossyroad

let rec play_game () : unit =
  ANSITerminal.(
    print_string [ white ] "\nWelcome to the Crossy Road: Oomp Ver!\n");
  ANSITerminal.(print_string [ white ] "\nPress 0 or enter zero to start. \n> ");
  let input = read_line () in
  if input = "0" || input = "zero" then (
    Graphics.open_graph " 1000x1000";
    Display.draw_start_screen ();
    Display.get_start_input ();
    ignore (Graphics.read_key ()))
  else (
    ANSITerminal.(print_string [ white ] "\nTry again!\n");
    play_game ())

let () = play_game ()