open import "prelude.ml"
open import "data/array.ml"
open import "../utils.ml"
open import "../parsing/lpeg.ml"
open import "../parsing/utils.ml"
module Map = import "data/map.ml"


let parser =
  let coords = collect_tuple @@ int_parser `seq` p"," `seq` int_parser
  let line = collect_tuple @@ coords `seq` p" -> " `seq` coords
  collect_list @@ sepseq line wsp

let pass_print x = let () = print x in x

let expand_line (x1, y1) (x2, y2) =
  (* let () = print ("expanding", (x1, y1), (x2, y2)) *)
  (if x1 == x2 then
      let ys = if y1 < y2 then [y1 .. y2] else [y2 .. y1]
      (* let () = print ("ys", ys) *)
      [(x1, y) | with y <- ys]
    else if y1 == y2 then
      let xs = if x1 < x2 then [x1 .. x2] else [x2 .. x1]
      (* let () = print ("xs", xs) *)
      [(x, y1) | with x <- xs ]
    else []) (* |> pass_print *)

let build_map (locs: list (int * int)) (m: Map.t (int * int) int): Map.t (int * int) int =
  let accum = Map.alter (function | Some x -> Some (x + 1) | None -> Some 1)
  foldr accum m locs

let res = read_input ()
          >>= parse parser
          |> map (map (fun (a, b) -> expand_line a b))
          (* |> map (map (fun line -> let () = print line in line)) *)
          |> map (foldr build_map Map.empty)
          |> map (foldr (fun count total -> if count > 1 then total + 1 else total) 0)

let () = print res
