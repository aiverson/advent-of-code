

open import "prelude.ml"
open import "../parsing/lpeg.ml"
open import "../parsing/utils.ml"

(* let parser = collect_list (sepseq int_parser wsp)
 *
 * let input = Io.read_all (Io.open_for_reading "input.txt") *)


let rec read_lines file : list string = match Io.read_line file with
  | Some s -> s :: (read_lines file)
  | None -> []

let () = print (
           let parsed = sequence @@ map parse_int (read_lines @@ Io.open_for_reading "input.txt")
           map (foldl (fun (count, old) new -> if old < new then (count + 1, new) else (count, new) ) (-1, -1)) parsed
)
