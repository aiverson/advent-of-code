open import "prelude.ml"
open import "data/array.ml"
open import "../utils.ml"
open import "../parsing/lpeg.ml"
open import "../parsing/utils.ml"
module Map = import "data/map.ml"


let parser =
  let calls = collect_list @@ nsepseq int_parser (p",")
  let board_row = collect_array @@ nsepseq int_parser (p " " `rep` 1)
  let board = collect_array @@ nsepseq board_row (p "\n" `seq` (p" " `rep` 0))
  collect_tuple @@ calls `seq` wsp `seq` collect_list (sepseq board wsp)

let pass_print x = let () = print x in x

let check_place_win (board: array (array bool)) x y : bool =
  let row = board .(y)
  let col = (fun r -> r.(x)) <$> board
  (* let () = print (row, col) *)
  all id (to_list row) || all id (to_list col)

type zboard_t <- array (array int) * array (array bool) * Map.t int (int * int)

let mark (call: int) ((slot, marks, slotlut): zboard_t) =
  let! (x, y) = slotlut.?(call)
  (* let () = print (x, y) *)
  let () = marks.(y).[x]<- true
  if check_place_win marks x y
    then Some ( zip_with (fun sr mr -> zip_with (fun s m -> if m then 0 else s) (to_list sr) (to_list mr)) (to_list slot) (to_list marks)
              |> join |> sum |> (call* ) )
    else None

let rec find_some = function
| Cons (Some x, _) -> Some x
| Cons (None, tail) -> find_some tail
| Nil -> None

let rec find_last_some = function
| Cons (Some x, tail) -> match find_last_some tail with | Some y -> Some y | None -> Some x
| Cons (None, tail) -> find_last_some tail
| Nil -> None

let advance zboards call = map (mark call) zboards

let remove_winning_boards zboards wins = zip_with (fun zb w -> match w with | Some _ -> [] | None -> [zb] ) zboards wins >>= id

let find_wins (zboards: list zboard_t) (calls: list int) =
  let zbs = ref zboards
  map (fun c -> let wins = (advance !zbs c) in zbs := remove_winning_boards !zbs wins; wins |> find_some ) calls



let res = read_input ()
          >>= parse parser
          >>= fun (calls, boards) ->
          let markers = map (map @@ map @@ const false) boards
          let lboards = map (map to_list %> to_list) boards
          let coords = imap (fun y row -> imap (fun x num -> (num, (x, y))) row) %> join <$> lboards
          let maps = map Map.from_list coords
          let zboards: list zboard_t = zip_with (,) boards @@ zip_with (,) markers maps
          let wins = find_wins zboards calls
          find_last_some wins

let () = print res
