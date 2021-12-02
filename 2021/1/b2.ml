

open import "prelude.ml"
open import "../parsing/lpeg.ml"
open import "../parsing/utils.ml"


let rec read_lines file : list string = match Io.read_line file with
  | Some s -> s :: (read_lines file)
  | None -> []

let () =
    let parsed = sequence @@ map parse_int @@ read_lines @@ Io.open_for_reading "input.txt"
    let regions = parsed |> map (fun p -> let ps = scanl (+) 0 p in zip_with (-) (tail @@ tail @@ tail ps) ps)
    let answer = map (foldl (fun (count, old) new -> if old < new then (count + 1, new) else (count, new)) (-1, -1)) regions
    print answer
    (* print (map window3 parsed) *)
