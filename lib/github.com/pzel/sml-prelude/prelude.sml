(*
   This code was copied from
   http://www.mlton.org/Utilities
   On 2025-01-05
   LICENSE: See attached LICENSE file

   Precedence changes follow
   http://www.mlton.org/InfixingOperators
   From 2025-01-05T17:09
*)

open Either.Cons

(* Operator precedence table *)
infix   8  * / div mod        (* +1 from Basis Library *)
infix   7  + - ^              (* +1 from Basis Library *)
infixr  6  :: @               (* +1 from Basis Library *)
infix   5  = <> > >= < <=     (* +1 from Basis Library *)
infix   3  <\ \>              (* See InifixingOperators *)
infixr  3  </ />              (* See InifixingOperators *)
infix   2 o                   (* See InifixingOperators *)
infix   2  >|
infixr  2  |<
infix   0  :=                 (* -3 from Basis Library *)
infix   0  before &

(* Some basic combinators *)
fun const x _ = x
fun cross (f, g) (x, y) = (f x, g y)
fun curry f x y = f (x, y)
fun fail e _ = raise e
fun id x = x

(* Product type *)
datatype ('a, 'b) product = & of 'a * 'b

(* Sum type *)
type ('a, 'b) sum = ('a, 'b) Either.either

(* Some type shorthands *)
type 'a uop = 'a -> 'a
type 'a fix = 'a uop -> 'a
type 'a thunk = unit -> 'a
type 'a effect = 'a -> unit
type ('a, 'b) emb = ('a -> 'b) * ('b -> 'a)

(* Infixing, sectioning, and application operators *)
fun x <\ f = fn y => f (x, y)
fun f \> y = f y
fun f /> y = fn x => f (x, y)
fun x </ f = f x

(* Piping operators *)
val op>| = op</
val op|< = op\>
