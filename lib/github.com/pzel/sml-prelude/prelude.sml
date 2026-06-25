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
fun flip f x y = f y x

(* tuple constructors *)
fun tup2 a b = (a,b)
fun tup3 a b c = (a,b,c)
fun tup4 a b c d = (a,b,c,d)
fun tup5 a b c d e = (a,b,c,d,e)
fun tup6 a b c d e f = (a,b,c,d,e,f)
fun tup7 a b c d e f g = (a,b,c,d,e,f,g)
fun tup8 a b c d e f g h = (a,b,c,d,e,f,g,h)
fun tup9 a b c d e f g h i = (a,b,c,d,e,f,g,h,i)

(* Product type *)
datatype ('a, 'b) product = & of 'a * 'b

(* aliases for N-ary productN types *)
type ('a, 'b) P = ('a, 'b) product
type ('a, 'b, 'c) product3 = (('a, 'b) P, 'c) P
type ('a, 'b, 'c, 'd) product4 = ((('a, 'b) P, 'c) P, 'd) P
type ('a, 'b, 'c, 'd, 'e) product5 = (((('a, 'b) P, 'c) P, 'd) P, 'e) P
type ('a, 'b, 'c, 'd, 'e, 'f) product6 = ((((('a, 'b) P, 'c) P, 'd) P, 'e) P, 'f) P
type ('a, 'b, 'c, 'd, 'e, 'f, 'g) product7 = (((((('a, 'b) P, 'c) P, 'd) P, 'e) P, 'f) P, 'g) P
type ('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h) product8 = ((((((('a, 'b) P, 'c) P, 'd) P, 'e) P, 'f) P, 'g) P, 'h) P
type ('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i) product9 = (((((((('a, 'b) P, 'c) P, 'd) P, 'e) P, 'f) P, 'g) P, 'h) P,'i) P


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
