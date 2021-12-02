
open import "prelude.ml"

let rec window n lst = if n == 1 then map (fun x -> [x]) lst else zip_with (::) lst (window (n - 1) (tail lst))
