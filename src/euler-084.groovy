/*
    I ran a simulation with a dice with 6 faces, I often ends up with 102400 and sometiens wth 102419
    With 4 faces, I often get 101524
 */

// board definition
def (GO, CC1, R1, CH1, JAIL, C1, U1, R2, CC2, CH2, E3, R3, U2, G2J, CC3, CH3, H2) = [0, 2, 5, 7, 10, 11, 12, 15, 17, 22, 24, 25, 28, 30, 33, 36, 39]
def (CC, CH, CH_TO_R, CH_TO_U) = [
    [CC1, CC2, CC3],
    [CH1, CH2, CH3],
    [(CH1): R2, (CH2): R3, (CH3): R1],
    [(CH1): U1, (CH2): U2, (CH3): U1]
]

// some states
def (doubles, card_CC, card_CH) = [0, 0, 0]

// compute next position
def next = { int from, int dice1, int dice2 ->

    // 1. If 3 consecutive doubles, go to jail
    doubles = dice1 == dice2 ? doubles + 1 : 0
    if (doubles == 3) {
        doubles = 0
        return JAIL
    }

    from = (from + dice1 + dice2) % 40

    // 2. Check if must go to jail
    if (from == G2J) return JAIL

    // 3. CC cards: 2/16 lead to an action
    if (from in CC) {
        card_CC = (card_CC + 1) % 16
        switch (card_CC) {
            case 1: return GO
            case 2: return JAIL
            default: return from
        }
    }

    // 4. CH cards: 10/16 lead to an action
    if (from in CH) {
        card_CH = (card_CH + 1) % 16
        switch (card_CH) {
            case 1: return GO
            case 2: return JAIL
            case 3: return C1
            case 4: return E3
            case 5: return H2
            case 6: return R1
            case 7: return CH_TO_R[from]
            case 8: return CH_TO_R[from]
            case 9: return CH_TO_U[from]
            case 10: return from - 3
            default: return from
        }
    }

    // otherwise remain on this place
    return from
}

def FACES = 4
def TURNS = 1000000
def (pos, player, board) = [GO, new Random(), (0..39).collectEntries { [(it): 0] }]

TURNS.times {
    pos = next pos, (player.nextInt(FACES) + 1), (player.nextInt(FACES) + 1)
    board[pos]++
}

println(board.sort { a, b -> b.value <=> a.value }.collect { it.key }[0..2].inject('', { str, v -> str + String.valueOf(v).padLeft(2, '0') }))
