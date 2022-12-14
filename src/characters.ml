(*define types for objects in game*)

type player = {
  mutable location : int * int;
  speed : int;
  frame : int;
  mutable steps : int;
  oompa_width : int;
  oompa_height : int;
}

type obj =
  | Tree
  | Rock
  | Water

type obstacle = {
  object_type : obj;
  location : int * int;
}

type moving =
  | Log
  | Car

type direction =
  | Right
  | Left

type moving_ob = {
  ob_type : moving;
  mutable location : int * int;
  mutable time : int;
  speed : int;
  frame : int;
  direction : direction;
}

type t = {
  oompa : player;
  characters_moving : moving_ob list;
  state : State.game_mode;
}

type e = Tick

let car_walk_n (c : moving_ob) : unit =
  let x, y = c.location in
  c.location <- (x - c.speed, y)

let rec check_coll (l : int * int) (cs : moving_ob list) =
  match cs with
  | [] -> None
  | h :: t ->
      let is_collsion (c : moving_ob) =
        if snd l <> snd c.location then false else fst l = fst c.location
      in
      if is_collsion h then Some h else check_coll l t

let update_game_state (map : t) =
  let new_state =
    match map.state with
    | Start -> State.Start
    | Fail -> State.Fail
    | Pause -> State.Pause
    | Play -> (
        let collision = check_coll map.oompa.location map.characters_moving in
        match collision with
        | None ->
            if snd map.oompa.location = 1000 then State.Fail else State.Play
        | Some _ -> State.Fail)
  in
  { map with state = new_state }

let tick (map : t) =
  match map.state with
  | Fail | Start | Pause -> map
  | Play ->
      let update_moving_object (c : moving_ob) =
        let new_position = fst c.location + c.speed in
        { c with location = (new_position, snd c.location) }
      in
      let new_moving_ob : moving_ob list =
        List.map update_moving_object map.characters_moving
      in
      let map_before = { map with characters_moving = new_moving_ob } in
      update_game_state map_before

let handle_event map (event : e) =
  match event with
  | Tick -> tick map

let spawn_moving_ob (l : int * int) (ob_type : moving) : moving_ob =
  match ob_type with
  | Log ->
      {
        ob_type;
        location = l;
        time = 0;
        speed = 40;
        frame = 0;
        direction = Right;
      }
  | Car ->
      {
        ob_type;
        location = l;
        time = 0;
        speed = 40;
        frame = 0;
        direction = Left;
      }

type car_list = { mutable hist_cars : moving_ob list }

let car_width = 100
let car_height = 50
let car_walk = car_width / 4

let trees (x : int) (y : int) =
  { object_type = Tree; location = (Random.int 1000 + x, Random.int 150 + y) }

let rock (x : int) (y : int) =
  { object_type = Rock; location = (Random.int 1000 + x, Random.int 200 + y) }

let create_car_lst (c : car_list) = { hist_cars = [] }
let add_car (c : car_list) (car : moving_ob) = c.hist_cars <- car :: c.hist_cars

(**When I initialize a car, need to call add_car to add the car to the car_list*)
let car (ty : moving) (x : int) (y : int) (t : int) (s : int) (f : int)
    (d : direction) =
  {
    ob_type = Car;
    location = (x, y);
    time = t;
    speed = s;
    frame = f;
    direction = d;
  }

let draw_car car_character () =
  Graphics.draw_rect
    (fst car_character.location)
    (snd car_character.location)
    car_width car_height

let rec move_car car_character hist dt =
  if hist != [] then
    if car_character.direction = Right then
      match hist with
      | [] -> failwith "None"
      | h :: t ->
          if fst h.location + car_walk + (car_width / 2) < 1000 then
            h.location <- (fst h.location + car_walk, snd h.location)
            (*else if fst h.location = 1000 then ( h.location <- (0, snd
              h.location); move_car car_character t dt) *)
          else (
            h.location <- (0, snd h.location);
            move_car car_character t dt)
    else if car_character.direction = Left then
      match hist with
      | [] -> failwith "None"
      | h :: t ->
          if fst h.location - car_walk - (car_width / 2) > 0 then
            h.location <- (fst h.location - dt, snd h.location)
          else (
            h.location <- (fst h.location, snd h.location);
            move_car car_character t dt)

let rec updateCar car_character hist_cars (dt : int) =
  (*if car_character.time < car_character.speed then car_character.time <-
    car_character.time + dt else *)
  match hist_cars with
  | [] -> ()
  | h :: t ->
      (*car_character.location <- (fst car_character.location - dt, snd
        car_character.location); *)
      move_car car_character hist_cars dt;
      updateCar car_character t dt

let draw_oompa (t : player) x y =
  let a = t.location = (x, y) in
  let b = t.speed = 0 in
  let c = t.frame = 0 in
  let d = t.steps = 0 in
  Graphics.draw_rect x y 30 30
