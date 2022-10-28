(* OCamLisp - STD *)

let newline = fun () -> 
  print_endline "";;

let puts_int = fun x -> 
  print_int x;
  newline ();;

let puts_float = fun x ->
  print_float x;
  newline ();;