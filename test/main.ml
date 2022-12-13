open OUnit2
open Crossyroad
open Characters

let check_test (name : string) (input : int) (output : int) : test =
  name >:: fun _ -> assert_equal input output ~printer:string_of_int

let check_state (name : string) input output : test =
  name >:: fun _ -> assert_equal input output

let check_tests =
  [
    check_test "basic check test" (4 + 6) 10;
    check_state "checking states"
      { location = (0, 0); object_type = Tree; speed = 0 }
      { location = (0, 0); object_type = Tree; speed = 0 };
  ]

let gui_tests = []
let state_tests = []

let suite =
  "crossy road: oopma loompa test suite"
  >::: List.flatten [ check_tests; gui_tests; state_tests ]

let _ = run_test_tt_main suite