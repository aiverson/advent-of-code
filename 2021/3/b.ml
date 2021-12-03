open import "prelude.ml"
open import "amulet/exception.ml"
open import "../utils.ml"
open import "../parsing/lpeg.ml"
open import "../parsing/utils.ml"

let bit = p"1" `seq` cc true `alt` (p "0" `seq` cc false)
let bits = collect_list @@ rep bit 1
let parser = collect_list @@ sepseq bits wsp

let int_from_bit x = if x then 1 else 0
let int_from_bits xs = map int_from_bit xs |> foldl (fun acc bit -> acc * 2 + bit) 0

let count_trues (bitss: list (list bool)) = foldl (zip_with (+)) [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] @@ map (map int_from_bit) bitss

let pull_first_bit (bits, value) = (head bits, tail bits, value)
let discard_first_bit (_, tl, value) = (tl, value)
let find_ratings bitss =
  let dupped = map (fun x -> (x, x)) bitss
  let pulled = map pull_first_bit dupped
  let rec separate values flag =
    let count = foldl (+) 0 @@ map ((fun (hd, _, _) -> hd) %> int_from_bit) values
    let total = length values
    (* let () = print (count, total) *)
    let subset = filter (fun (hd, _, _) -> if (count*2 >= total) then hd == flag else hd == not flag ) values
    match subset with
    | [] -> throw (Invalid "should never have an empty list here")
    | [(_, _, value)] -> value
    | vals -> separate (map (discard_first_bit %> pull_first_bit) vals) flag
  (separate pulled true, separate pulled false)

let res = read_input ()
          >>= parse parser
          >>= fun bitss ->
            let (oxy, co2) = find_ratings bitss
            (* let () = print (oxy, co2) *)
            Some ((int_from_bits oxy) * (int_from_bits co2))

let () = print res
