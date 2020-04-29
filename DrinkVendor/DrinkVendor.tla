---- MODULE DrinkVendor ----
EXTENDS Integers
VARIABLES coin, drink, money

TypeOK == /\ coin = {100}
          /\ drink \in {0, 1}
          /\ money \in {0, 100}

Init == /\ coin = 100
        /\ drink = 0
        /\ money = 0

First == /\ drink' = 0
         /\ money' = 100
         /\ coin' = coin

Second == /\ drink' = 1
          /\ money' = 0
          /\ coin' = coin

Next == \/ First
        \/ Second

====
