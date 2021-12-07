
open import "prelude.ml"

let rec window n lst = if n == 1 then map (fun x -> [x]) lst else zip_with (::) lst (window (n - 1) (tail lst))

let read_input () = Io.read_all (Io.open_for_reading "input.txt")

let ($>) x f = f <$> x
