open import "prelude.ml"
open import "../utils.ml"
open import "../parsing/lpeg.ml"
open import "../parsing/utils.ml"

let bit = p"1" `seq` cc true `alt` (p "0" `seq` cc false)
let bits = collect_list @@ rep bit 1
let parser = collect_list @@ sepseq bits wsp

let int_from_bit x = if x then 1 else 0
let int_from_bits xs = map int_from_bit xs |> foldl (fun acc bit -> acc * 2 + bit) 0

let count_trues (bitss: list (list bool)) = foldl (zip_with (+)) [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] @@ map (map int_from_bit) bitss

let res = read_input ()
          >>= parse parser
          >>= fun bitss ->
            let counts = count_trues bitss
            let len = length bitss
            let common = map (fun x -> x > len // 2) counts
            let least_common = map (not) common
            Some ((int_from_bits common) * (int_from_bits least_common))

let () = print res
