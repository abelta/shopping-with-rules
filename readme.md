Shopping with rules
======

Coffeescript demo showcasing a checkout process where the price of the items can be altered in real time with promotions.

Extendable
------

The pattern chosen to implement the discounts allows not only for discounts of the type 2x1 or bulk3 but 3x2, 5x4, bulk4, bulk5, etc...
More discount types can be added via inheritance in the future.

Execute
------

With Node and Coffeescript installed, run coffee `main.coffee`.

Test
------

Run all tests with command `jasmine`.