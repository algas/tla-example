---- MODULE fizzbuzz ----
EXTENDS Integers
MaxIndex == 100

FizzBuzzFunc(n) ==
    CASE (n % 3 = 0) /\ (n % 5 = 0) -> "FizzBuzz"
      [] n % 3 = 0 -> "Fizz"
      [] n % 5 = 0 -> "Buzz"
      [] OTHER -> n

(*--algorithm fizzbuzz
variables
    i = 1,
    f = "";

begin
    FizzBuzz:
        while i <= MaxIndex do
            f := FizzBuzzFunc(i);
            Loop:
                i := i + 1;
        end while;
end algorithm; *)
\* BEGIN TRANSLATION
VARIABLES i, f, pc

vars == << i, f, pc >>

Init == (* Global variables *)
        /\ i = 1
        /\ f = ""
        /\ pc = "FizzBuzz"

FizzBuzz == /\ pc = "FizzBuzz"
            /\ IF i <= MaxIndex
                  THEN /\ f' = FizzBuzzFunc(i)
                       /\ pc' = "Loop"
                  ELSE /\ pc' = "Done"
                       /\ f' = f
            /\ i' = i

Loop == /\ pc = "Loop"
        /\ i' = i + 1
        /\ pc' = "FizzBuzz"
        /\ f' = f

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == FizzBuzz \/ Loop
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION
====
