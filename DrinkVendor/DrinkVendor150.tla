---- MODULE DrinkVendor150 ----
EXTENDS Integers, TLC
(*--algorithm DrinkVendor150
variables
    coin \in {50, 100},
    drink \in {0, 1},
    ret \in {0, 50},
    money \in {0, 50, 100};

begin
    drink := 0;
    ret := 0;
    money := 100;
    while TRUE do
        either coin := 50;
        or     coin := 100;
        end either;
        if money + coin < 150 then
            drink := 0;
            ret := 0;
            money := money + coin;
        elsif money + coin = 150 then
            drink := 1;
            ret := 0;
            money := 0;
        else
            drink := 1;
            ret := money + coin - 150;
            money := 0;
        end if;
    end while;
end algorithm; *)
\* BEGIN TRANSLATION
VARIABLES coin, drink, ret, money, pc

vars == << coin, drink, ret, money, pc >>

Init == (* Global variables *)
        /\ coin \in {50, 100}
        /\ drink \in {0, 1}
        /\ ret \in {0, 50}
        /\ money \in {0, 50, 100}
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ drink' = 0
         /\ ret' = 0
         /\ money' = 100
         /\ pc' = "Lbl_2"
         /\ coin' = coin

Lbl_2 == /\ pc = "Lbl_2"
         /\ \/ /\ coin' = 50
            \/ /\ coin' = 100
         /\ IF money + coin' < 150
               THEN /\ drink' = 0
                    /\ ret' = 0
                    /\ money' = money + coin'
               ELSE /\ IF money + coin' = 150
                          THEN /\ drink' = 1
                               /\ ret' = 0
                               /\ money' = 0
                          ELSE /\ drink' = 1
                               /\ ret' = money + coin' - 150
                               /\ money' = 0
         /\ pc' = "Lbl_2"

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1 \/ Lbl_2
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

====
