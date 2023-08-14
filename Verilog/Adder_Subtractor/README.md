# Fast 32-bit adder/subtractor
Table of content:
- [Fast 32-bit adder/subtractor](#fast-32-bit-addersubtractor)
  - [Description](#description)
  - [Design](#design)
    - [Full adder](#full-adder)
    - [Logic control Adder/Subtractor](#logic-control-addersubtractor)
    - [Carry look ahead adder](#carry-look-ahead-adder)
  - [Final block diagram](#final-block-diagram)

## Description
This project build a combined 32-bit adder and subtractor, using Carry look ahead adder **(CLA)** circuitry for reducing delay time, and two's complement to convert a positive binary number into negative binary number for subtraction. CLA produces the intermediate carry in signal immediately instead of waiting for them to be created by the preceding full adder stage.

**INPUT**:
- ***A[31:0]***, ***B[31:0]***: two number 32-bit input
- ***Select***: control signal for adder or subtractor will be selected

**OUTPUT**:
- ***Sum[31:0]***: result of the calculation
- ***Co***: carry out signal

***A*** and ***B*** can be either signed or unsigned number. Adder is performed when ***Select*** signal is logic 0, and Subtractor is performed when ***Select*** signal is logic 1.

## Design
### Full adder
**Truth table for Full Adder**:
|   A   |   B   |   C   |   Co  |  Sum  |
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
$$Co = A.B + (A+B).C \space or \space Co=A.B + (A \oplus B).C$$
$$Sum = A \oplus B \oplus C$$
With ***A, B*** are two input number, ***C*** is carry input signal, the result is ***Sum*** and ***Co*** for carry-out signal.

### Logic control Adder/Subtractor
- Negative number can represent by 2's complement: by inverse bit and add 1 to positive number.
- Subtraction for negative number is equivalent to addition for the 2's complement of negative number.

Example:
$$A = 0011(3) \rightarrow (-A) = 1100(-4) + 1 = 1101(-3)$$
$$(-B) = 1011(-5) \rightarrow [-(-B)] = B = 0100(4) + 1 = 0101(5)$$

**Truth table for logic control Adder/Subtractor**:<br>
When ***Select*** signal is logic 0, the input number has no change, and when ***Select*** signal is logic 1, the input number is inversed.
| Select (S)| Input bit (Ib) | Inversed bit (Ob) |
|-----------|----------------|-----------------|
|     0     |       0        |       0         |
|     0     |       1        |       1         |
|     1     |       0        |       1         |
|     1     |       1        |       0         |

The expression for ***Inversed bit*** is:
$$Ob = \overline{S}.Ib + S.\overline{Ib} = S \oplus Ib$$
So, we apply XOR gate for each bit of the input  ***B*** number before of the full adder.

### Carry look ahead adder
The carry-out function for stage i can be realized as:
$$C_{i+1} = A_i.B_i + (A_i+B_i).C_i$$
Assum:
$$g_i = A_i.B_i$$
$$p_i = A_i + B_i$$
So:
$$C_{i+1} = g_i + p_i.C_i$$
Example for expanding stage 0 to stage 3:
$$C_1 = g_0 + p_0.C_0$$
$$C_2 = g_1 + p_1.g_0 + p_0.p_1.C_0$$
$$C_3 = g_2 + p_2.g_1 + p_1.p_2.g_0 + p_0.p_1.p_2.C_0$$
$$C_4 = g_3 + p_3.g_2 + p_2.p_3.g_1 + p_1.p_2.p_3.g_0+ p_0.p_1.p_2.p_3.C_0$$

## Final block diagram
The 32-bit carry-out signal will be broken down to 8x4-block CLA for simple fan-in logic gate, and XOR gate will be applied before full-adder. Therefore, the final block diagram is:

![final-fast-add-sub-diagram](https://github.com/GSXAM/LearningFPGA/blob/master/images/final-fast-add-sub-diagram.svg)
