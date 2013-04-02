from itertools import permutations

def PE68(nGon=5):
    def rec(rem, s, sol, b, minLen):
        ans=0; m=sol[-1]
        if len(rem)==1:
            if s-b-m in rem:
                sol = sol + (s-b-m, m, b,)
                start=min(sol[k] for k in range(0,len(sol),3))
                while sol[0]!=start: sol=sol[3:]+sol[:3]
                stringSol=(''.join(map(str,sol)))
                return int(stringSol) if len(stringSol)==minLen else 0
            else: return 0
        for x, y in permutations(rem,2):
            if x+y+m==s:
                nRem=tuple(t for t in rem if t not in (x,y))
                ans=max(ans,rec(nRem,s,sol+(x,m,y,),b,minLen))
        return ans
    ans=0
    valid=tuple(range(1,2*nGon+1))
    minLen=2*len(''.join(map(str,valid[:nGon])))+len(''.join(map(str,valid[-nGon:])))

    for a,b,c in permutations(valid,3):
        s=a+b+c
        rem=tuple(t for t in valid if t not in (a,b,c))
        ans=max(ans,rec(rem,a+b+c,(a,b,c,),b,minLen))
    return ans

print PE68(5)
