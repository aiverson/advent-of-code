

open import "prelude.ml"
open import "../parsing/lpeg.ml"
open import "../parsing/utils.ml"


let rec read_lines file : list string = match Io.read_line file with
  | Some s -> s :: (read_lines file)
  | None -> []

let rec window3 lst = match lst with
 | [] -> []
 | [_] -> []
 | [_, _] -> []
 | [a, b, c] -> [[a, b, c]]
 | Cons (a, Cons (b, Cons (c, _)) as tail) -> [a, b, c] :: window3 tail

let () =
    let parsed = sequence @@ map parse_int @@ read_lines @@ Io.open_for_reading "input.txt"
    let answer = map (foldl (fun (count, old) new -> let newsum = sum new in if old < newsum then (count + 1, newsum) else (count, newsum)) (-1, -1) % window3) parsed
    print answer
    (* print (map window3 parsed) *)
