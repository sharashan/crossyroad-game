open OUnit2
open Crossyroad
open Characters
open Display
open Constants

(* Test Plan : There are parts of the system that were automatically tested by
   OUnit. These mainly included from the state.ml files and for the gui,
   checking if the character.ml file has initiated the objects and obstacles
   with the proper fields. The OUnit checks if the fields are correct.
   Additionally, the OUnit checks collision with the player and the obstacle
   based on the location and the boolean of whether the locations actually
   collide or not. The automatic testing of our system is for correctness of
   fields and states for the different objects.

   Manual testing is applied to many other parts of the system such as the
   randomization of trees in the specific grass area and the stones in the
   river. It was also applied to maintain proper correctness of the collisions
   and movement that OUnit testing cannot maintain.

   The testing approach used here is mostly glass-box testing since the
   implementation of the functions is what drove the implementation of the tests
   with the different test cases. There was no randomized testing used. The test
   cases were picked looking at how the implementation introduces boundaries
   that show what inputs need to produce what outputs. Especially with the
   different boundary cases and types that need to be tested.*)
let check_test (name : string) (input : int) (expected_output : int) : test =
  name >:: fun _ -> assert_equal input expected_output ~printer:string_of_int

let check_state_test (name : string) (input : obstacle)
    (expected_output : obstacle) : test =
  name >:: fun _ -> assert_equal input expected_output

let check_player_test (name : string) (input : player)
    (expected_output : player) : test =
  name >:: fun _ -> assert_equal input expected_output

let false_test input expected_output =
  input >:: fun _ -> assert (not (expected_output ()))

let check_moving_test (name : string) (input : moving_ob)
    (expected_output : moving_ob) : test =
  name >:: fun _ -> assert_equal input expected_output

let test_oompa =
  {
    location = (0, 0);
    speed = 0;
    frame = 0;
    steps = 0;
    oompa_width = 10;
    oompa_height = 10;
  }

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
    check_player_test "testing states"
      {
        location = (0, 0);
        speed = 0;
        frame = 0;
        steps = 0;
        oompa_width = 50;
        oompa_height = 50;
      }
      {
        location = (0, 0);
        speed = 0;
        frame = 0;
        steps = 0;
        oompa_width = 50;
        oompa_height = 50;
      };
    check_state_test "checking states" test_tree_obstacle test_tree_obstacle;
    check_state_test "checking states"
      { object_type = Rock; location = (30, 30) }
      { object_type = Rock; location = (30, 30) };
    check_state_test "checking states"
      { object_type = Tree; location = (30, 30) }
      { object_type = Tree; location = (30, 30) };
    check_state_test "checking states" test_rock_obstacle test_rock_obstacle;
    check_moving_test "checking state" test_moving_obstacle test_moving_obstacle;
    check_moving_test "checking states"
      {
        ob_type = Car;
        location = (20, 20);
        time = 10;
        speed = 2;
        frame = 10;
        direction = Left;
      }
      {
        ob_type = Car;
        location = (20, 20);
        time = 10;
        speed = 2;
        frame = 10;
        direction = Left;
      };
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

let get_moving_obstacle (name : string) (input : Characters.moving_ob)
    (expected_output : Characters.moving_ob) : test =
  name >:: fun _ -> assert_equal expected_output input

let get_obstacle (name : string) (input : Characters.obstacle)
    (expected_output : Characters.obstacle) : test =
  name >:: fun _ -> assert_equal expected_output input

let get_gui_player (name : string) (input : player) (expected_output : player) :
    test =
  name >:: fun _ -> assert_equal expected_output input

let get_player_speed (name : string) (input : player) (expected_output : int) :
    test =
  name >:: fun _ ->
  assert_equal expected_output input.speed ~printer:string_of_int

let get_player_frame (name : string) (input : player) (expected_output : int) :
    test =
  name >:: fun _ ->
  assert_equal expected_output input.frame ~printer:string_of_int

let get_player_width (name : string) (input : player) (expected_output : int) :
    test =
  name >:: fun _ ->
  assert_equal expected_output input.oompa_width ~printer:string_of_int

let get_player_height (name : string) (input : player) (expected_output : int) :
    test =
  name >:: fun _ ->
  assert_equal expected_output input.oompa_height ~printer:string_of_int

let get_gui_obstacle_type (name : string) (input : obstacle)
    (expected_output : obj) : test =
  name >:: fun _ -> assert_equal expected_output input.object_type

let obstacle_list = []
let colliding_tree = { object_type = Tree; location = (10, 0) }
let non_collision_list = [ test_rock_obstacle ]
let collision_list = [ colliding_tree ]
let colliding_car_list = []

let colliding_car =
  {
    ob_type = Car;
    location = (10, 0);
    time = 10;
    speed = 11;
    frame = 12;
    direction = Right;
  }

let colliding_car_list = [ colliding_car ]

let check_collision (name : string) (input : obstacle list)
    (second_input : Characters.player) (expected_output : bool) : test =
  name >:: fun _ ->
  assert_equal expected_output (Display.collision second_input input)

let get_gui_obstacle_type (name : string) (input : obstacle)
    (expected_output : obj) : test =
  name >:: fun _ -> assert_equal expected_output input.object_type

let get_gui_moving_obs_type (name : string) (input : moving_ob)
    (expected_output : moving) : test =
  name >:: fun _ -> assert_equal expected_output input.ob_type

let get_gui_moving_time (name : string) (input : moving_ob)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output input.time ~printer:string_of_int

let get_gui_moving_speed (name : string) (input : moving_ob)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output input.speed ~printer:string_of_int

let get_gui_moving_frame (name : string) (input : moving_ob)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output input.frame ~printer:string_of_int

let get_gui_moving_direction (name : string) (input : moving_ob)
    (expected_output : direction) : test =
  name >:: fun _ -> assert_equal expected_output input.direction

let get_background (name : string) (input : background_type)
    (expected_output : background) : test =
  name >:: fun _ -> assert_equal expected_output input.back_type

let back_river_create = { back_type = River; location = (100, 100) }
let back_grass_create = { back_type = Grass; location = (200, 100) }
let spawn_car = Characters.spawn_moving_ob (10, 10) Car

let check_spawn_car =
  {
    ob_type = Car;
    location = (10, 10);
    time = 0;
    speed = 40;
    frame = 0;
    direction = Left;
  }

let gui_tests =
  let oompa =
    {
      location = (10, 0);
      speed = 0;
      frame = 0;
      steps = 1;
      oompa_width = 75;
      oompa_height = 80;
    }
  in
  let gui_tree = { object_type = Tree; location = (50, 50) } in
  let gui_car =
    {
      ob_type = Car;
      location = (100, 100);
      time = 10;
      speed = 11;
      frame = 12;
      direction = Right;
    }
  in
  let left_car =
    {
      ob_type = Car;
      location = (100, 100);
      time = 10;
      speed = 11;
      frame = 12;
      direction = Left;
    }
  in
  [
    get_background "check background types" back_river_create River;
    get_background "check background types" back_grass_create Grass;
    oompa_walk_test "oompa walking" oompa { oompa with location = (10, 0) };
    get_steps "testing steps" oompa 1;
    get_player_speed "testing speed" oompa 0;
    get_player_speed "testing frame" oompa 0;
    get_player_width "testing width" oompa 75;
    get_player_height "testing height" oompa 80;
    get_gui_obstacle_type
      "testing obstacle type with newly created tree implemented in different \
       location"
      gui_tree Tree;
    get_gui_moving_obs_type "testing moving obstacle type" gui_car Car;
    get_gui_moving_time "testing moving obstacle time" gui_car 10;
    get_gui_moving_speed "testing moving obstacle speed" gui_car 11;
    get_gui_moving_frame "testing moving obstacle frame" gui_car 12;
    get_gui_moving_direction "testing moving obstacle direction" gui_car Right;
    get_gui_moving_direction "testing moving obstacle direction" left_car Left;
    get_gui_player "testing player width" oompa { oompa with oompa_width = 75 };
    get_gui_player "testing player height" oompa
      { oompa with oompa_height = 80 };
    get_moving_obstacle "checking type of moving obstacle" test_moving_obstacle
      { test_moving_obstacle with ob_type = Car };
    get_moving_obstacle "checking location of moving obstacle"
      test_moving_obstacle
      { test_moving_obstacle with location = (20, 20) };
    get_moving_obstacle "checking time of moving obstacle" test_moving_obstacle
      { test_moving_obstacle with time = 10 };
    get_moving_obstacle "checking speed of moving obstacle" test_moving_obstacle
      { test_moving_obstacle with speed = 2 };
    get_moving_obstacle "checking frame of moving obstacle" test_moving_obstacle
      { test_moving_obstacle with frame = 10 };
    get_moving_obstacle "checking direction of moving obstacle"
      test_moving_obstacle
      { test_moving_obstacle with direction = Left };
    get_obstacle "checking type of tree obstacle" test_tree_obstacle
      { test_tree_obstacle with object_type = Tree };
    get_obstacle "checking location of tree obstacle" test_tree_obstacle
      { test_tree_obstacle with location = (10, 10) };
    get_obstacle "checking type of rock obstacle" test_rock_obstacle
      { test_rock_obstacle with object_type = Rock };
    get_obstacle "checking location of rock obstacle" test_rock_obstacle
      { test_rock_obstacle with location = (30, 30) };
    check_collision "checking collision with empty list so it returns false"
      obstacle_list oompa false;
    check_collision
      "checking collision with non-empty list so but not colliding so it \
       returns false"
      non_collision_list oompa false;
    get_moving_obstacle "checking type of moving obstacle" spawn_car
      { check_spawn_car with ob_type = Car };
    get_moving_obstacle "checking location of moving obstacle" spawn_car
      { check_spawn_car with location = (10, 10) };
    get_moving_obstacle "checking time of moving obstacle" spawn_car
      { check_spawn_car with time = 0 };
    get_moving_obstacle "checking speed of moving obstacle" spawn_car
      { check_spawn_car with speed = 40 };
    get_moving_obstacle "checking frame of moving obstacle" spawn_car
      { check_spawn_car with frame = 0 };
    get_moving_obstacle "checking direction of moving obstacle" spawn_car
      { check_spawn_car with direction = Left };
  ]

let test_string_to_state (name : string) (input : string)
    (expected_output : State.game_mode) : test =
  name >:: fun _ -> assert_equal expected_output (State.string_to_state input)

let test_state_t_start =
  {
    State.game_state = State.Start;
    mouse_pressed = false;
    arrow_pressed = true;
  }

let test_state_t_play =
  {
    State.game_state = State.Play;
    mouse_pressed = false;
    arrow_pressed = false;
  }

let test_state_t_pause =
  {
    State.game_state = State.Pause;
    mouse_pressed = false;
    arrow_pressed = true;
  }

let test_state_t_fail =
  {
    State.game_state = State.Fail;
    mouse_pressed = false;
    arrow_pressed = false;
  }

let test_state_t_win =
  { State.game_state = State.Win; mouse_pressed = true; arrow_pressed = false }

let get_state_t (name : string) (input : State.t) (expected_output : State.t) :
    test =
  name >:: fun _ -> assert_equal expected_output input

let get_game_mode (name : string) (input : State.t)
    (expected_output : State.game_mode) : test =
  name >:: fun _ -> assert_equal expected_output input.game_state

let state_tests =
  [
    test_string_to_state "testing start state" "start" State.Start;
    test_string_to_state "testing play state" "play" State.Play;
    test_string_to_state "testing pause state" "pause" State.Pause;
    test_string_to_state "testing fail state" "fail" State.Fail;
    test_string_to_state "testing win state" "win" State.Win;
    get_game_mode "testing game mode" test_state_t_win State.Win;
    get_state_t "checking start state" test_state_t_start
      { test_state_t_start with State.game_state = State.Start };
    get_state_t "checking play state" test_state_t_play
      { test_state_t_play with State.game_state = State.Play };
    get_state_t "checking pause state" test_state_t_pause
      { test_state_t_pause with State.game_state = State.Pause };
    get_state_t "checking fail state" test_state_t_fail
      { test_state_t_fail with State.game_state = State.Fail };
    get_state_t "checking win state" test_state_t_win
      { test_state_t_win with State.game_state = State.Win };
    get_state_t "checking mouse key with state play" test_state_t_play
      { test_state_t_play with State.mouse_pressed = false };
    get_state_t "checking arrow key with state play" test_state_t_play
      { test_state_t_play with State.arrow_pressed = false };
    get_state_t "checking mouse key with state fail" test_state_t_fail
      { test_state_t_fail with State.mouse_pressed = false };
    get_state_t "checking arrow key with state fail" test_state_t_fail
      { test_state_t_fail with State.arrow_pressed = false };
    get_state_t "checking mouse key with state start" test_state_t_start
      { test_state_t_start with State.arrow_pressed = true };
    get_state_t "checking mouse key with state win" test_state_t_win
      { test_state_t_win with State.mouse_pressed = true };
  ]

let suite =
  "crossy road: oopma loompa test suite"
  >::: List.flatten [ check_tests; gui_tests; state_tests ]

let _ = run_test_tt_main suite