open OUnit2
open Crossyroad

let gui_tests = []
let state_tests = []

let suite =
  "crossy road: oopma loompa test suite"
  >::: List.flatten [ gui_tests; state_tests ]

let _ = run_test_tt_main suite