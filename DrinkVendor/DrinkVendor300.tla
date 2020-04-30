---- MODULE DrinkVendor300 ----
EXTENDS Integers, TLC
(*--algorithm DrinkVendor300
variables
    drink \in {0, 1},
    money \in {0, 100, 200};

define
    moneyVendor300(m) ==
        CASE m = 200 -> 0
        [] m = 100 -> 200
        [] OTHER -> 100

    drinkVendor300(m) ==
        CASE m = 200 -> 1
        [] OTHER -> 0
end define;

begin
    drink := 0;
    money := 0;
    while TRUE do
        drink := drinkVendor300(money);
        money := moneyVendor300(money);
        assert (drink = 1 /\ money = 0) \/ drink = 0
    end while;
end algorithm; *)
\* BEGIN TRANSLATION
VARIABLES drink, money, pc

(* define statement *)
moneyVendor300(m) ==
    CASE m = 200 -> 0
    [] m = 100 -> 200
    [] OTHER -> 100

drinkVendor300(m) ==
    CASE m = 200 -> 1
    [] OTHER -> 0

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
         /\ drink' = drinkVendor300(money)
         /\ money' = moneyVendor300(money)
         /\ Assert((drink' = 1 /\ money' = 0) \/ drink' = 0,
                   "Failure of assertion at line 35, column 9.")
         /\ pc' = "Lbl_2"

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1 \/ Lbl_2
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION
====
