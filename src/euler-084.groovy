import java.security.SecureRandom

def (GO, CC1, R1, CH1, JAIL, C1, U1, R2, CC2, CH2, E3, R3, U2, G2J, CC3, CH3, H2) = [0, 2, 5, 7, 10, 11, 12, 15, 17, 22, 24, 25, 28, 30, 33, 36, 39]

def board = [0] * 40

def (pos, doubles) = [GO, 0]

SecureRandom player = new SecureRandom()

// One turn...

def dices = [player.nextInt(6) + 1, player.nextInt(6) + 1]

// determine position

// 1. If 3 consecutive doubles, go to jail
doubles = dices[0] == dices[1] ? doubles + 1 : 0
if (doubles == 3) {
    doubles = 0
    pos = JAIL
}

pos = (pos + dices.sum()) % 40

// 2. Check if must go to jail
if (pos == G2J) {
    pos = JAIL
}

//