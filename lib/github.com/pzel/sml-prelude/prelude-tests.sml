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


    in
      print "\nOK\n"
    end;
