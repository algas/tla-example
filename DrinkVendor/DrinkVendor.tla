---- MODULE DrinkVendor ----
EXTENDS Integers, TLC
(*--algorithm DrinkVendor
variables
    drink = 0,
    money = 100;

begin
    while TRUE do
        if money > 0 then
            money := 0;
            drink := 1;
        else
            money := 100;
            drink := 0;
        end if;
        assert money \in {0, 100};
        assert drink \in {0, 1};
    end while;
end algorithm; *)
\* BEGIN TRANSLATION
VARIABLES drink, money

vars == << drink, money >>

Init == (* Global variables *)
        /\ drink = 0
        /\ money = 100

Next == /\ IF money > 0
              THEN /\ money' = 0
                   /\ drink' = 1
              ELSE /\ money' = 100
                   /\ drink' = 0
        /\ Assert(money' \in {0, 100}, 
                  "Failure of assertion at line 17, column 9.")
        /\ Assert(drink' \in {0, 1}, 
                  "Failure of assertion at line 18, column 9.")

Spec == Init /\ [][Next]_vars

\* END TRANSLATION

====
