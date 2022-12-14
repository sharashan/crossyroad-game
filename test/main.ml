open OUnit2
open Crossyroad
open Characters
open Display

(** [pp_string s] pretty-prints string [s]. *)
let pp_string s = "\"" ^ s ^ "\""

let check_test (name : string) (input : int) (expected_output : int) : test =
  name >:: fun _ -> assert_equal input expected_output ~printer:string_of_int

let check_state_test (name : string) input expected_output : test =
  name >:: fun _ -> assert_equal input expected_output

let test_oompa = { location = (0, 0); speed = 0; frame = 0; steps = 0 }

let test_moving_obstacle =
  {
    ob_type = Car;
    location = (20, 20);
    time = 10;
    speed = 2;
    frame = 10;
    direction = Left;
  }

let test_tree_obstacle = { object_type = Tree; location = (10, 10) }
let test_rock_obstacle = { object_type = Rock; location = (30, 30) }

let check_tests =
  [
    check_test "basic check test" (4 + 6) 10;
    check_state_test "testing states"
      { location = (0, 0); speed = 0; frame = 0; steps = 0 }
      { location = (0, 0); speed = 0; frame = 0; steps = 0 };
    check_state_test "checking states" test_tree_obstacle test_tree_obstacle;
    check_state_test "checking state" test_moving_obstacle test_moving_obstacle;
  ]

let oompa_walk_test (name : string) (input : Characters.player)
    (expected_output : Characters.player) : test =
  name >:: fun _ ->
  assert_equal expected_output
    (move_oompa input 'a' [];
     input)

let get_steps (name : string) (input : player) (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output input.steps ~printer:string_of_int

let get_moving_obstacle_type (name : string) (input : Characters.moving_ob)
    (expected_output : Characters.moving_ob) : test =
  name >:: fun _ -> assert_equal expected_output input

let get_obstacle_type (name : string) (input : Characters.obstacle)
    (expected_output : Characters.obstacle) : test =
  name >:: fun _ -> assert_equal expected_output input

let get_player_speed (name : string) (input : player) (expected_output : int) :
    test =
  name >:: fun _ -> assert_equal expected_output input.speed

let get_player_frame (name : string) (input : player) (expected_output : int) :
    test =
  name >:: fun _ -> assert_equal expected_output input.frame

let get_gui_obstacle_type (name : string) (input : obstacle)
    (expected_output : obj) : test =
  name >:: fun _ -> assert_equal expected_output input.object_type

let get_gui_obstacle_type (name : string) (input : obstacle)
    (expected_output : obj) : test =
  name >:: fun _ -> assert_equal expected_output input.object_type

let obstacle_list = []
let colliding_tree = { object_type = Tree; location = (10, 0) }
let non_collision_list = [ test_rock_obstacle ]
let collision_list = [ colliding_tree ]

let check_collision (name : string) (input : 'a list)
    (second_input : Characters.player) (expected_output : bool) : test =
  name >:: fun _ ->
  assert_equal expected_output (Display.collision second_input input)

let gui_tests =
  let oompa = { location = (10, 0); speed = 0; frame = 0; steps = 1 } in
  let gui_tree = { object_type = Tree; location = (50, 50) } in
  [
    oompa_walk_test "oompa walking" oompa { oompa with location = (10, 0) };
    get_steps "testing steps" oompa 1;
    get_player_speed "testing speed" oompa 0;
    get_player_speed "testing frame" oompa 0;
    get_gui_obstacle_type "testing obstacle type" gui_tree Tree;
    get_moving_obstacle_type "checking type of moving obstacle"
      test_moving_obstacle
      { test_moving_obstacle with ob_type = Car };
    get_moving_obstacle_type "checking location of moving obstacle"
      test_moving_obstacle
      { test_moving_obstacle with location = (20, 20) };
    get_moving_obstacle_type "checking time of moving obstacle"
      test_moving_obstacle
      { test_moving_obstacle with time = 10 };
    get_moving_obstacle_type "checking speed of moving obstacle"
      test_moving_obstacle
      { test_moving_obstacle with speed = 2 };
    get_moving_obstacle_type "checking frame of moving obstacle"
      test_moving_obstacle
      { test_moving_obstacle with frame = 10 };
    get_moving_obstacle_type "checking direction of moving obstacle"
      test_moving_obstacle
      { test_moving_obstacle with direction = Left };
    get_obstacle_type "checking type of tree obstacle" test_tree_obstacle
      { test_tree_obstacle with object_type = Tree };
    get_obstacle_type "checking location of tree obstacle" test_tree_obstacle
      { test_tree_obstacle with location = (10, 10) };
    get_obstacle_type "checking type of rock obstacle" test_rock_obstacle
      { test_rock_obstacle with object_type = Rock };
    get_obstacle_type "checking location of rock obstacle" test_rock_obstacle
      { test_rock_obstacle with location = (30, 30) };
    check_collision "checking collision with empty list so it returns false"
      obstacle_list oompa false;
    check_collision
      "checking collision with non-empty list so but not colliding so it \
       returns false"
      non_collision_list oompa false;
  ]

let test_string_to_state (name : string) (input : string)
    (expected_output : State.game_mode) : test =
  name >:: fun _ -> assert_equal expected_output (State.string_to_state input)

let test_state_t_start =
  {
    State.game_state = State.Start;
    mouse_pressed = false;
    arrow_pressed = false;
  }

let state_tests =
  [
    test_string_to_state "testing start state" "start" State.Start;
    test_string_to_state "testing play state" "play" State.Play;
    test_string_to_state "testing pause state" "pause" State.Pause;
    test_string_to_state "testing fail state" "fail" State.Fail;
  ]

let suite =
  "crossy road: oopma loompa test suite"
  >::: List.flatten [ check_tests; gui_tests; state_tests ]

let _ = run_test_tt_main suite