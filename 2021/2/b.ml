

open import "prelude.ml"
open import "../parsing/lpeg.ml"
open import "../parsing/utils.ml"

let entry = collect_tuple @@ c (p"up"`alt`p"down"`alt`p"forward") `seq` wsp `seq` int_parser

let parser = collect_list @@ sepseq entry wsp

let input = Io.read_all (Io.open_for_reading "input.txt") >>= parse parser

let res = foldl (fun (x, y, aim) line ->
                   match line with
                   | ("up", dy) -> (x, y, aim - dy)
                   | ("down", dy) -> (x, y, aim + dy)
                   | ("forward", dx) -> (x + dx, y + aim * dx, aim)
                   | _ -> (x, y, aim)
                ) (0, 0, 0) <$> input

let () = print @@ (fun (x, y, _) -> x * y) <$> res
