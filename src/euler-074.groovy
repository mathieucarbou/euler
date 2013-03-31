int NB = 1000000
int[] F = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]
int[] C = new int[NB + 1]

C[169] = C[363601] = C[1454] = 3;
C[871] = C[45361] = 2;
C[872] = C[45362] = 2;

for (int n = 1; n <= NB; n++) {
    if (n % 10 == 1) {
        C[n] = C[n - 1]
        continue
    }
    if (!C[n]) {
        def l = new LinkedList<Integer>([n])
        while (true) {
            int nn = l.getFirst()
            s = 0
            while (nn) {
                s += F[nn % 10]
                nn = nn / 10
            }
            if (s <= NB && C[s]) {
                for (int i = l.size() - 1; i >= 0; i--)
                    if (l[i] <= NB)
                        C[l[i] as int] = C[s] + i + 1
                break
            }
            int k = l.indexOf(s)
            if (k != -1) {
                for (int i = l.size() - 1; i >= 0; i--)
                    if (l[i] <= NB)
                        C[l[i] as int] = (i < k ? k : i) + 1
                break
            }
            l.addFirst(s)
        }
    }
}
println C.findAll { it == 60 }.size()
