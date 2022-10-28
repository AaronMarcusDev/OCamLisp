(* OCamLisp - STD *)

let newline = fun () -> 
  print_endline "";;

let puts_int = fun v -> 
  print_int v;
  newline ();;

let puts_float = fun v ->
  print_float v;
  newline ();;