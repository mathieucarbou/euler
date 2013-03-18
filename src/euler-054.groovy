import static Value.*

enum Suit {
    S, H, D, C
}

enum Value {
    _2, _3, _4, _5, _6, _7, _8, _9, _T, _J, _Q, _K, _A

    String toString() { name().substring(1) }

    static Value from(String s) { Value.values().find { it.name().substring(1) == s } }
}

class Card implements Comparable<Card> {

    Suit suit
    Value value

    int compareTo(Card o) { value.compareTo(o.value) }

    String toString() { "${value}${suit}" }

    static Card valueOf(String s) {
        new Card(
            value: Value.from(s[0]),
            suit: Suit.valueOf(s[1])
        )
    }
}

enum Category {
    HighCard, OnePair, TwoPairs, ThreeOfAKind, Straight, Flush, FullHouse, FourOfAKind, StraightFlush, RoyalFlush

    static Collection<CategoryHand> parse(Collection<Card> cards) {
        cards = cards.sort(false)
        Suit s = sameSuit(cards)
        boolean c = consecutive(cards)
        Collection<Value> v4 = sameValue(cards, 4)
        Collection<Value> v3 = sameValue(cards, 3)
        Collection<Value> v2 = sameValue(cards, 2)
        if (s && c && cards.collect { it.value } == [_T, _J, _Q, _K, _A]) {
            return [
                new CategoryHand(
                    category: RoyalFlush,
                    suit: s
                )
            ]
        }
        if (s && c) {
            return [
                new CategoryHand(
                    category: StraightFlush,
                    suit: s,
                    values: [cards[4].value]
                )
            ]
        }
        if (v4) {
            return [
                new CategoryHand(
                    category: FourOfAKind,
                    values: v4
                ),
                new CategoryHand(
                    category: HighCard,
                    values: cards.findAll { !(it.value in v4) }.collect { it.value }.sort().reverse(true)
                )
            ]
        }
        if (v3 && v2) {
            return [
                new CategoryHand(
                    category: FullHouse,
                    values: v3 + v2
                )
            ]
        }
        if (s) {
            return [
                new CategoryHand(
                    category: Flush,
                    suit: s,
                    values: [cards[4].value]
                )
            ]
        }
        if (c) {
            return [
                new CategoryHand(
                    category: Straight,
                    values: [cards[4].value]
                )
            ]
        }
        if (v3) {
            return [
                new CategoryHand(
                    category: ThreeOfAKind,
                    values: v3
                ),
                new CategoryHand(
                    category: HighCard,
                    values: cards.findAll { !(it.value in v3) }.collect { it.value }.sort().reverse(true)
                )
            ]
        }
        if (v2) {
            return [
                new CategoryHand(
                    category: v2.size() == 2 ? TwoPairs : OnePair,
                    values: v2
                ),
                new CategoryHand(
                    category: HighCard,
                    values: cards.findAll { !(it.value in v2) }.collect { it.value }.sort().reverse(true)
                )
            ]
        }
        return [
            new CategoryHand(
                category: HighCard,
                values: cards.collect { it.value }.sort().reverse(true)
            )
        ]
    }

    static Collection<Value> sameValue(Collection<Card> cards, int n) {
        return cards.groupBy { it.value }.findAll { k, v -> v.size() == n }.collect { k, v -> k }.sort().reverse(true)
    }

    static boolean consecutive(Collection<Card> cards) {
        if (cards.size() < 2) return false
        for (int i = 1; i < cards.size(); i++) if (cards[i].value.ordinal() - cards[i - 1].value.ordinal() != 1) return false
        return true
    }

    static Suit sameSuit(Collection<Card> cards) {
        def s = cards.collect { it.suit }.unique()
        return s.size() == 1 ? s[0] : null
    }
}

class CategoryHand implements Comparable<CategoryHand> {
    Category category
    Collection<Value> values = []
    Suit suit

    String toString() { "${category}: ${suit ?: values}" }

    int compareTo(CategoryHand o) {
        int d = category.compareTo(o.category)
        if (d != 0) return d
        for (int i = 0; i < values.size() && i < o.values.size(); i++) {
            d = values[i].compareTo(o.values[i])
            if (d != 0) return d
        }
        return 0
    }
}

class Player {
    String name

    String toString() { name }

    Hand newHand(Collection<Card> cards) {
        Hand h = new Hand(
            player: this,
            categories: Category.parse(cards)
        )
        return h
    }
}

class Hand implements Comparable<Hand> {

    Player player
    Collection<CategoryHand> categories = []

    String toString() { "${player}: ${categories}" }

    int compareTo(Hand o) {
        int i = 0
        for (i; i < categories.size() && i < o.categories.size(); i++) {
            int d = categories[i].compareTo(o.categories[i])
            if (d != 0) return d
        }
        return 0
    }
}

class Set {
    Collection<Hand> hands = []

    String toString() { "${hands.join(' VS ')} => ${winners*.player}" }

    Collection<Hand> getWinners() {
        if (!hands) return []
        def h = hands.sort(false)
        def w = []
        w << h.pop()
        while (h) {
            def i = h.pop()
            if (w[0] == i) w << i
        }
        return w.reverse(true)
    }
}

def player1 = new Player(
    name: 'Player 1'
)

def player2 = new Player(
    name: 'Player 2'
)

def sets = new File("../data/poker.txt").collect { String line ->
    def cards = line.split(' ').collect { Card.valueOf(it) }
    return new Set(
        hands: [
            player1.newHand(cards[0..4]),
            player2.newHand(cards[5..9])
        ]
    )
}

//sets.each { println it }
println(sets.findAll { it.winners.with { it.size() == 1 && it[0].player == player1 } }.size())
