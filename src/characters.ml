(*define types for objects in game*)

type player = {
  mutable location : int * int;
  speed : int;
  frame : int;
  mutable steps : int;
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

type car_list = { mutable hist_cars : moving_ob list }

let car_width = 100
let car_height = 50
let car_walk = car_width / 4

let trees (x : int) (y : int) =
  { object_type = Tree; location = (Random.int 1000 + x, Random.int 150 + y) }

let rock (x : int) (y : int) =
  { object_type = Rock; location = (Random.int 1000 + x, Random.int 150 + y) }

let create_car_lst (c : car_list) = { hist_cars = [] }
let add_car (c : car_list) (car : moving_ob) = c.hist_cars <- car :: c.hist_cars

(**When I initialize a car, need to call add_car to add the car to the car_list*)
let car (ty : moving) (x : int) (y : int) (time : int) (s : int) (f : int)
    (d : direction) =
  {
    ob_type = Car;
    location = (x, y);
    time;
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
          else move_car car_character t dt

let updateCar car_character car_list (dt : int) =
  if car_character.time < car_character.speed then
    car_character.time <- car_character.time + dt
  else (
    if car_list.hist_cars != [] then car_character.time <- 0;
    move_car car_character car_list.hist_cars dt)

let draw_oompa (t : player) x y =
  let a = t.location = (x, y) in
  let b = t.speed = 0 in
  let c = t.frame = 0 in
  let d = t.steps = 0 in
  Graphics.draw_rect x y 30 30
