/*
    A^2 + B^2 = C^2
    A + B + C = 1000
*/

// naive nethod:
loop:
for (A in 1..1000) {
    for (B in 1..1000) {
        C = 1000 - A - B
        if (A * A + B * B == C * C) {
            println(A*B*C)
            break loop
        }
    }
}


