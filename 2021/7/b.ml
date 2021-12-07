open import "prelude.ml"
open import "data/array.ml"
open import "../utils.ml"
open import "../parsing/lpeg.ml"
open import "../parsing/utils.ml"
module Map = import "data/map.ml"


let parser =
  collect_list @@ nsepseq int_parser (p ",")

let make_map lst = foldr (Map.alter (function | None -> Some 1 | Some x -> Some (x + 1))) Map.empty lst

let max a b = if a > b then a else b
let min a b = if a < b then a else b

let bounds m = Map.keys m |> (foldl1 min &&& foldl1 max )

let positions (a, b) = [a .. b]

let or_default x d = match x with | Some x -> x | None -> d

let costs subs positions = tail @@ scanl (fun (count, step_cost, cost, _) newpos -> (count + subs.?(newpos) `or_default` 0, step_cost + count, cost + step_cost + count, newpos)) (0, 0, 0, 0) positions

let solve (initials: list int) =
  let subs = make_map initials
  let bs : int * int = bounds subs
  let pos = positions bs
  let c1 = costs subs pos
  let c2 = reverse @@ costs subs @@ reverse pos
  let totalcost = zip_with (fun (_, _, costl, _) (_, _, costr, _) -> costl + costr) c1 c2
  (* c1 *)
  foldl1 min totalcost

let res = read_input ()
          >>= parse parser
          |> map solve

let () = print res
