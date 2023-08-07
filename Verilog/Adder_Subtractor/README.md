# Fast 32-bit adder/subtractor
Table of content:
- [Fast 32-bit adder/subtractor](#fast-32-bit-addersubtractor)
  - [Description](#description)
  - [Architecture](#architecture)
  - [Design](#design)
    - [Full adder](#full-adder)
    - [Logic control Adder/Subtractor](#logic-control-addersubtractor)
    - [Carry look ahead adder](#carry-look-ahead-adder)

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
![fast-adder-subtractor-diagram](https://github.com/GSXAM/LearningFPGA/blob/master/images/fast-adder-subtractor-diagram.svg)

## Design
### Full adder
**Truth table for Full Adder**:
|   A   |   B   |   C  |   Co  |  Sum  |
|-------|-------|-------|-------|-------|
|   0   |   0   |   0   |   0   |   0   |
|   0   |   0   |   1   |   0   |   1   |
|   0   |   1   |   0   |   0   |   1   |
|   0   |   1   |   1   |   1   |   0   |
|   1   |   0   |   0   |   0   |   1   |
|   1   |   0   |   1   |   1   |   0   |
|   1   |   1   |   0   |   1   |   0   |
|   1   |   1   |   1   |   1   |   1   |

Therefore, the expression for ***Sum*** and ***Co*** is:
$$Co = A.B + (A+B).Ci$$
$$Sum = A \oplus B \oplus Ci$$
With ***C*** is Carry input signal.

### Logic control Adder/Subtractor
- Negative number can represent by 2's complement: by inverse bit and add 1 to positive number.
- Subtraction for negative number is equivalent to addition for the 2's complement of negative number.

Example:
$$A = 0011(3) \rightarrow (-A) = 1100(-4) + 1 = 1101(-3)$$
$$(-B) = 1011(-5) \rightarrow [-(-B)] = B = 0100(4) + 1 = 0101(5)$$

**Truth table for logic control Adder/Subtractor**:
| Select (S)| Input bit (Ib) | Output bit (Ob) |
|-----------|----------------|-----------------|
|     0     |       0        |       0         |
|     0     |       1        |       1         |
|     1     |       0        |       1         |
|     1     |       1        |       0         |

The expression for ***Output bit*** is:
$$Ob = \overline{S}.Ib + S.\overline{Ib} = S \oplus Ib$$
So, we apply XOR gate for each bit of ***B*** number before of the full adder.

### Carry look ahead adder
The carry-out function for stage i can be realized as:
$$C_{i+1} = A_i.B_i + (A_i+B_i).C_i$$
Assum:
$$g_i = A_i.B_i$$
$$p_i = A_i + B_i$$
So:
$$C_{i+1} = g_i + p_i.C_i$$
Example for expanding stage 0 and stage 1:
$$C_1 = g_0 + p_0.C_0$$
$$C_2 = g_1 + p_1.(g_0 + p_0.C_0)$$
$$C_3 = g_2 + p_2.[g_2 + p_2.(g_0 + p_0.C_0)]$$