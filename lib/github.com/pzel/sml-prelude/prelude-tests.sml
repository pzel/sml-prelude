fun test desc f = if f ()
                  then print "."
                  else (print ("\nFailed: " ^ desc ^ "\n"); raise (Fail ("Test failed;" ^ desc)))

fun main () =
    let
     val _ = test "sectioning and composition" (
           fn _ => let fun idx s = Word8.fromInt o Char.ord o s <\String.sub
                   in idx "hello" 0 = 0wx68
                   end);
     val _ = test "assigning result of infixed application" (
           fn _ => let val x = ref #"0"
                       val s = "hello"
                       val i = 0
                       val _ = x := s <\String.sub\> i
                   in !x = #"h"
                   end);
     val _ = test "mapping a partial infix" (
           fn _ => let fun subN n = List.map (op- /> n)
                       val sub2 = subN 2
                       val sub3 = subN 3
                       val list = [1,2,3]
                   in
                     list = sub2 [3,4,5]
                     andalso
                     list = sub3 [4,5,6]
                   end);
     val _ = test "eliminating parentheses" (
           fn _ => let val res = Int.toString \> 1 + 2
                   in res = "3"
                   end);

     val _ = test "piping" (
           fn _ => let val res = Int.toString \> 1 + 2
                   in res = "3"
                   end)

     val _ = test "Either is reexported but INR is implicitly there" (
           fn _ => let val right = INR 3
                   in Either.asRight right = SOME 3
                   end)

     val _ = test "flip flips arguments" (
           fn _ => let fun subtract a b = a - b
                       val f = flip subtract
                       val res = f 3 5
                       in res = 2
                   end)

     val _ = test "up to 9-ary products can be type with productN alias, constructed and deconstructed" (
           fn _ => let val (a & b) : (int, int) product =
                           1 & 2
                       val (a & b & c) : (int, int, string) product3 =
                           1 & 2 & "a"
                       val (a & b & c & d ) : (int, int, string, 'a list) product4 =
                           1 & 2 & "a" & []
                       val (a & b & c & d & e) : (int, int, string, 'a list, int list) product5 =
                           1 & 2 & "a" & [] & [1]
                       val (a & b & c & d & e & f) : (int, int, string, 'a list, int list, unit) product6 =
                           1 & 2 & "a" & [] & [1] & ()
                       val (a & b & c & d & e & f & g) : (int, int, string, 'a list, int list, unit, ('a -> 'a)) product7 =
                           1 & 2 & "a" & [] & [1] & () & (fn x => x)
                       val (a & b & c & d & e & f & g & h) : (int, int, string, 'a list, int list, unit, ('a -> 'a), char) product8 =
                           1 & 2 & "a" & [] & [1] & () & (fn x => x) & #"a"
                       val (a & b & c & d & e & f & g & h & i) : (int, int, string, 'a list, int list, unit, ('a -> 'a), char, bool) product9 =
                           1 & 2 & "a" & [] & [1] & () & (fn x => x) & #"a" & true
                       in 3 = a + b andalso (g i)
                   end)



    in
      print "\nOK\n"
    end;
