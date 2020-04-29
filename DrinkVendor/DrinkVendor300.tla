---- MODULE DrinkVendor300 ----
EXTENDS Integers, TLC
(*--algorithm DrinkVendor300
variables
    drink \in {0, 1},
    money \in {0, 100, 200};

begin
    drink := 0;
    money := 0;
    while TRUE do
        if money > 100 then
            money := 0;
            drink := 1;
        elsif money > 0 then
            money := 200;
            drink := 0;
        else
            money := 100;
            drink := 0;
        end if;
        assert (drink = 1 /\ money = 0) \/ drink = 0
    end while;
end algorithm; *)
\* BEGIN TRANSLATION
VARIABLES drink, money, pc

vars == << drink, money, pc >>

Init == (* Global variables *)
        /\ drink \in {0, 1}
        /\ money \in {0, 100, 200}
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ drink' = 0
         /\ money' = 0
         /\ pc' = "Lbl_2"

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF money > 100
               THEN /\ money' = 0
                    /\ drink' = 1
               ELSE /\ IF money > 0
                          THEN /\ money' = 200
                               /\ drink' = 0
                          ELSE /\ money' = 100
                               /\ drink' = 0
         /\ Assert((drink' = 1 /\ money' = 0) \/ drink' = 0, 
                   "Failure of assertion at line 22, column 9.")
         /\ pc' = "Lbl_2"

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1 \/ Lbl_2
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION
====
