# Fast 32-bit adder/subtractor
Table of content:
- [Fast 32-bit adder/subtractor](#fast-32-bit-addersubtractor)
  - [Description](#description)
  - [Architecture](#architecture)

## Description
This project build a combined 32-bit adder and subtractor, using Carry look ahead adder **(CLA)** circuitry for reducing delay time. CLA produces the intermediate carry in signal immediately instead of waiting for them to be created by the preceding full adder stage.

**INPUT**:
- ***A[31:0]***, ***B[31:0]***: two number 32-bit input
- ***Select***: control signal for adder or subtractor will be selected

**OUTPUT**:
- ***Sum***: result of the calculation
- ***Co***: carry out signal

***A*** and ***B*** can be either signed or unsigned number. Adder is performed when ***Select*** signal is logic 0, and Subtractor is performed when ***Select*** signal is logic 1.

## Architecture


**Truth table for Full Adder**:
|   A   |   B   |   Ci  |       |   Co  |  Sum  |
|-------|-------|-------|-------|-------|-------|
|   0   |   0   |   0   |       |   0   |   0   |
|   0   |   0   |   1   |       |   0   |   1   |
|   0   |   1   |   0   |       |   0   |   1   |
|   0   |   1   |   1   |       |   1   |   0   |
|   1   |   0   |   0   |       |   0   |   1   |
|   1   |   0   |   1   |       |   1   |   0   |
|   1   |   1   |   0   |       |   1   |   0   |
|   1   |   1   |   1   |       |   1   |   1   |

Therefore, the expression for ***Sum*** and ***Co*** is:<br>
$$Co = A.B + (A+B).Ci$$
$$Sum = A⊕B⊕Ci$$
With ***Ci*** is Carry input signal.