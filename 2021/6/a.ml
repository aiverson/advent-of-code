open import "prelude.ml"
open import "data/array.ml"
open import "../utils.ml"
open import "../parsing/lpeg.ml"
open import "../parsing/utils.ml"
module Map = import "data/map.ml"


let parser =
  collect_list @@ nsepseq int_parser (p ",")


let collapse_pop lst = foldr (Map.alter (function | Some x -> Some (x + 1) | None -> Some 1)) Map.empty lst

let add_pop_seg (state, count) m = Map.alter (function | Some x -> Some (x + count) | None -> Some count) state m
let gen_pop_suc (state, count) = if state == 0 then [ (6, count), (8, count) ] else [ (state - 1, count) ]
let update_pop (m: Map.t int int) = m |> Map.assocs |> map gen_pop_suc |> join |> foldr (fun seg m -> add_pop_seg seg m ) Map.empty
let rec iter_times count (f : 'a -> 'a) (x: 'a) = if count == 0 then x else iter_times (count - 1) f (f x)

let pop_ff days init = iter_times days update_pop init

let res = read_input ()
          >>= parse parser
          |> map collapse_pop
          |> map (pop_ff 256)
          |> map to_list
          |> map (foldl (+) 0)

let () = print res
