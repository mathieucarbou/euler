int i = 1, p = 1
StringBuilder sb = new StringBuilder()
while (sb.size() < 1000000) sb.append(i++)
for (i = 1; i <= 1000000; i *= 10) p *= sb[i - 1] as int
println(p)
