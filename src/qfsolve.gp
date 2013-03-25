\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\\       Copyright (C) 2012 Denis Simon
\\
\\ Distributed under the terms of the GNU General Public License (GPL)
\\
\\    This code is distributed in the hope that it will be useful,
\\    but WITHOUT ANY WARRANTY; without even the implied warranty of
\\    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
\\    General Public License for more details.
\\
\\ The full text of the GPL is available at:
\\
\\                 http://www.gnu.org/licenses/
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

/*
  Author:
  Denis SIMON -> simon@math.unicaen.fr
  address of the file:
  www.math.unicaen.fr/~simon/qfsolve.gp

  *********************************************
  *          VERSION 26/09/2012               *
  *********************************************

  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  \\                English help                \\
  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  This package provides functions to solve quadratic equations over Q.
  language: GP
  It can be run under GP by the command
  gp > \r qfsolve.gp

  This package contains 4 main functions:

  - Qfsolve(G,factD): solve over Q the quadratic equation X~*G*X = 0.
  G must be a symmetric matrix n*n, with coefficients in Z.
  If no solution exists, the output is a prime number
  indicating that there is no solution in the local field Q_p
  (-1 for the reals).
  This algorithm requires the factorization of -abs(2*matdet(G)).
  If this factorization is known, one can give it as factD (the second
  argument of the function) and save a lot of time.

  Example:
  gp > G = [1,0,0;0,1,0;0,0,-34];
  gp > Qfsolve(G)
  %1 = [-3, -5, 1]~

  - Qfparam(G,sol,fl): coefficients of quadratic forms that parametrize the
  solutions of the ternary quadratic form G, using the particular
  solution sol.
  fl is optional and can be 1, 2, or 3, then the 'fl'th form is reduced.

  Example:
  gp > Qfparam(G,[-3,-5,1]~)
  %2 = 
  [ 3 -10 -3]

  [-5  -6  5]

  [ 1   0  1]
  Indeed, the solutions can be parametrized as
  [3*x^2 - 10*y*x - 3*y^2, -5*x^2 - 6*y*x + 5*y^2, x^2 + y^2]~
  
  - IndefiniteLLL(G,c): Solve or reduce the quadratic form G with
  integral coefficients. G might be definite or indefinite.
  This is an LLL-type algorithm with a constant 1/4<c<1. 

  - class2(d,factd): computes the 2-Sylow of the (narrow) class group
  of discriminant d. d must be a fondamental discriminant.
  This algorithm requires the factorization of abs(2*d).
  If this factorization is known, one can give it as factd (the second
  argument of the function) and the algorithm runs in polynomial time.

  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  \\         Description des fonctions          \\
  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  Programme de resolution des equations quadratiques
  langage: GP
  pour l'utiliser, lancer gp, puis taper
  \r qfsolve.gp

  Ce fichier contient 4 principales fonctions:

  - Qfsolve(G,factD): pour resoudre l'equation quadratique X^t*G*X = 0
  G doit etre une matrice symetrique n*n, a coefficients dans Z.
  S'il n'existe pas de solution, la reponse est un entier
  indiquant un corps local dans lequel aucune solution n'existe
  (-1 pour les reels, p pour Q_p).
  Si on connait la factorisation de -abs(2*matdet(G)),
  on peut la passer par le parametre factD pour gagner du temps.

  Exemple:
  gp > G = [1,0,0;0,1,0;0,0,-34];
  gp > Qfsolve(G)
  %1 = [-3, -5, 1]~

  - Qfparam(G,sol,fl): pour parametrer les solutions de la forme
  quadratique ternaire G, en utilisant la solution particuliere sol.
  si fl>0, la 'fl'eme forme quadratique est reduite.

  Exemple:
  gp > Qfparam(G,[-3,-5,1]~)
  %2 = 
  [ 3 -10 -3]

  [-5  -6  5]

  [ 1   0  1]
  Ici, les solutions sont parametrees par
  [3*x^2 - 10*y*x - 3*y^2, -5*x^2 - 6*y*x + 5*y^2, x^2 + y^2]~

  - IndefiniteLLL(G,c): pour resoudre ou reduire la forme quadratique
  G a coefficients entiers. Il s'agit d'un algorithme type LLL, avec la
  constante 1/4<c<1.

  - class2(d,factd): determine le 2-Sylow du (narrow) groupe de classes de
  discriminant d, ou d est un discriminant fondamental.
  Si on connait la factorisation de abs(2*d),
  on peut la donner dans factd, et dans ce cas le reste
  de l'algorithme est polynomial.

*/

\\
\\ Usual global variables
\\ 

global(DEBUGLEVEL_qfsolve:small);

  DEBUGLEVEL_qfsolve = 0; \\ From 0 to 5 : choose a higher value to have
                          \\ more details printed.


\\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\\          SCRIPT                             \\
\\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

{default_qfsolve(DEBUGLEVEL_qfsolve_val:small = 0) =

  DEBUGLEVEL_qfsolve = DEBUGLEVEL_qfsolve_val;
  print("  DEBUGLEVEL_qfsolve = ",DEBUGLEVEL_qfsolve);
}
{QfbReduce(M) =
\\ M = [a,b;b;c] has integral coefficients.
\\ Reduction of the binary quadratic form
\\   qf = (a,b,c)=a*X^2+2*b*X*Y+c*Y^2
\\ Returns the reduction matrix with det = +1.

local(a,b,c,H,test,di,q,r,nexta,nextb,nextc,aux);

if( DEBUGLEVEL_qfsolve >= 5, print("     starting QfbReduce with ",M));

  a = M[1,1]; b = M[1,2]; c = M[2,2];
  
  H = matid(2); test = 1;
  while( test && a,
    di = divrem(b,a); q = di[1]; r = di[2];
    if( 2*r > abs(a), r -= abs(a); q += sign(a));
    H[,2] -= q*H[,1];
    nextc = a; nextb = -r; nexta= (nextb-b)*q+c;
 
    if( test = abs(nexta) < abs(a),
      c = nextc; b = nextb; a = nexta;
      aux = H[,1]; H[,1] = -H[,2]; H[,2] = aux
    ) 
  );

if( DEBUGLEVEL_qfsolve >= 5, print("     end of QfbReduce with ",H));
return(H);
}
{IndefiniteLLL(G,c=1,base=0) =
\\ Performs first a LLL reduction on a positive definite
\\ quadratic form QD bounding the indefinite G.
\\ Then finishes the reduction with IndefiniteLLL2.

local(n,M,QD,M1,S,red);

  n = length(G);
  M = matid(n);
  QD = G;
  for( i = 1, n-1,
    if( !QD[i,i],
return(IndefiniteLLL2(G,c,base))
    );
    M1 = matid(n);
    M1[i,] = -QD[i,]/QD[i,i];
    M1[i,i] = 1;
    M = M*M1;
    QD = M1~*QD*M1
  );
  M = M^(-1);
  QD = M~*abs(QD)*M;
  S = qflllgram(QD/content(QD));
  if( #S < n, S = completebasis(S));
  red = IndefiniteLLL2(S~*G*S,c,base);
  if( type(red) == "t_COL",
return(S*red));
  if( length(red) == 3,
return([red[1],S*red[2],S*red[3]]));
return([red[1],S*red[2]]);
}
{IndefiniteLLL2(G,c=1,base=0) =
\\ following Cohen's book p. 86
\\ but without b and bstar: works on G
\\ returns [H~*G*H,H] where det(H) = 1 and H~*G*H is reduced.
\\ Exit with a norm 0 vector if one such is found.
\\ If base == 1 and norm 0 is obtained, returns [H~*G*H,H,sol] where 
\\   sol is a norm 0 vector and is the 1st column of H.

local(n,H,M,A,aux,sol,k,swap,q,di,HM,aux1,aux2,Mkk1,bk1new,Mkk1new,newG);

  n = length(G);
if( DEBUGLEVEL_qfsolve >= 3, print("   LLL dim ",n," avec |G| = ",log(vecmax(abs(G)))/log(10)));
if( DEBUGLEVEL_qfsolve >= 4, print("    LLL with ");print(G));

 if( n <= 1, return([G,matid(n)]));

  H = M = matid(n); A = matrix(n,n);

\\ compute Gram-Schmidt  

  for( i = 1, n,
    if( !(A[i,i] = G[i,i]),
      if( base,
        aux = H[,1]; H[,1] = H[,i]; H[,i] = -aux;
        return([H~*G*H,H,H[,1]])
      , return(M[,i])));
    for( j = 1, i-1,
      A[i,j] = G[i,j] - sum( k = 1, j-1, M[j,k]*A[i,k]);
      M[i,j] = A[i,j]/A[j,j];
      A[i,i] -= M[i,j]*A[i,j];
      if( !A[i,i], 
        sol = (M^(-1))~[,i]; sol /= content(sol);
        if( base,
          H = completebasis(sol);
          aux = H[,1]; H[,1] = H[,n]; H[,n]= -aux;
          return([H~*G*H,H,H[,1]])
        , return(sol)))
    )
  );

\\ LLL loop

  k = 2;
  while( k <= n,

    swap = 1;
    while( swap,
      swap = 0;

\\ red(k,k-1);
      if( q = round(M[k,k-1]),
        for( i = 1, k-2, M[k,i] -= q*M[k-1,i]);
        M[k,k-1] -= q;
        for( i = 1, n,
          A[k,i] -= q*A[k-1,i];
          H[i,k] -= q*H[i,k-1]
        )
      );

\\ preparation of swap(k,k-1)

      if( issquare( di = -A[k-1,k-1]*A[k,k]),
\\ di is the determinant of matr
\\ We find a solution
        HM = (M^(-1))~;
        aux1 = sqrtint(numerator(di));
        aux2 = sqrtint(denominator(di));
        sol = aux1*HM[,k-1]+aux2*A[k-1,k-1]*HM[,k];
        sol /= content(sol);
        if( base,
          H = H*completebasis(sol,1);
          aux = H[,1]; H[,1] = H[,n]; H[,n] = -aux;
          return([H~*G*H,H,H[,1]])
        , return(H*sol)
        )
      );

\\ Reduction [k,k-1].
      Mkk1 = M[k,k-1];
      bk1new = Mkk1^2*A[k-1,k-1] + A[k,k];
      if( swap = abs(bk1new) < c*abs(A[k-1,k-1]),
        Mkk1new = -Mkk1*A[k-1,k-1]/bk1new
      );

\\ Update the matrices after the swap.
      if( swap,
        for( j = 1, n,
          aux = H[j,k-1]; H[j,k-1] = H[j,k]; H[j,k] = -aux);
        for( j = 1, k-2,
          aux = M[k-1,j]; M[k-1,j] = M[k,j]; M[k,j] = -aux);
        for( j = k+1, n,
          aux = M[j,k]; M[j,k] = -M[j,k-1]+Mkk1*aux; M[j,k-1] = aux+Mkk1new*M[j,k]);
        for( j = 1, n, if( j != k && j != k-1,
          aux = A[k-1,j]; A[k-1,j] = A[k,j]; A[k,j] =- aux;
          aux = A[j,k-1]; A[j,k-1] = Mkk1*aux+A[j,k]; A[j,k] = -aux-Mkk1new*A[j,k-1]));

        aux1 = A[k-1,k-1];
        aux2 = A[k,k-1];
        A[k,k-1]  =-A[k-1,k] - Mkk1*aux1;
        A[k-1,k-1]= A[k,k]   + Mkk1*aux2;
        A[k,k]    = aux1     - Mkk1new*A[k,k-1];
        A[k-1,k]  =-aux2     - Mkk1new*A[k-1,k-1];

        M[k,k-1] = Mkk1new;

if( DEBUGLEVEL_qfsolve >=4, newG=H~*G*H;print(vector(n,i,matdet(vecextract(newG,1<<i-1,1<<i-1)))));

        if( k != 2, k--)
      )
    );

    forstep( l = k-2, 1, -1,
\\ red(k,l)
      if( q = round(M[k,l]),
        for( i = 1, l-1, M[k,i] -= q*M[l,i]);
        M[k,l] -= q;
        for( i = 1, n,
          A[k,i] -= q*A[l,i];
          H[i,k] -= q*H[i,l]
        )
      )
    );
    k++
  );
return([H~*G*H,H]);
}
{kermodp(M,p) =
\\ Compute the kernel of M mod p.
\\ returns [d,U], where
\\ d = dim (ker M mod p)
\\ U in GLn(Z), and its first d columns span the kernel.

local(n,U,d);

  n = length(M);
  U = centerlift(matker(M*Mod(1,p)));
  d = length(U);
  U = completebasis(U);
  U = matrix(n,n,i,j,U[i,n+1-j]);
return([d,U]);
}
{Qfparam(G,sol,fl=3) =
\\ G is a symmetric 3x3 matrix, and sol a solution of sol~*G*sol=0.
\\ Returns a parametrization of the solutions with the good invariants,
\\ as a matrix 3x3, where each line contains
\\ the coefficients of each of the 3 quadratic forms.

\\ If fl!=0, the fl-th form is reduced.

local(U,G1,G2);

if( DEBUGLEVEL_qfsolve >= 5, print("     starting Qfparam"));
  sol /= content(sol);
\\ build U such that U[,3] = sol, and det(U) = +-1
  U = completebasis(sol,1);
  G1 = U~*G*U; \\ G1 has a 0 at the bottom right corner
  G2 = [-2*G1[1,3],-2*G1[2,3],0;
      0,-2*G1[1,3],-2*G1[2,3];
      G1[1,1],2*G1[1,2],G1[2,2]];
  sol = U*G2;
  if(fl,
    U = IndefiniteLLL([sol[fl,1],sol[fl,2]/2; sol[fl,2]/2,sol[fl,3]],1,1)[2];
    U = [U[1,1]^2,2*U[1,2]*U[1,1],U[1,2]^2;
         U[2,1]*U[1,1],U[2,2]*U[1,1]+U[2,1]*U[1,2],U[1,2]*U[2,2];
         U[2,1]^2,2*U[2,1]*U[2,2],U[2,2]^2];
    sol = sol*U
  );
if( DEBUGLEVEL_qfsolve >= 5, print("     end of Qfparam"));
return(sol);
}
{LLLgoon3(G,c=1) =
\\ LLL reduction of the quadratic form G (Gram matrix)
\\ in dim 3 only, with detG = -1 and sign(G) = [1,2];

local(red,U1,G2,bez,U2,G3,cc,U3);

  red = IndefiniteLLL(G,c,1);
\\ We always find an isotropic vector.
  U1 = [0,0,1;0,1,0;1,0,0];
  G2 = U1~*red[1]*U1;
\\ G2 has a 0 at the bottom right corner.
  bez = bezout(G2[3,1],G2[3,2]);
  U2 = [bez[1],G2[3,2]/bez[3],0;bez[2],-G2[3,1]/bez[3],0;0,0,-1];
  G3 = U2~*G2*U2;
\\ G3 has 0 under the co-diagonal.
  cc = G3[1,1]%2;
  U3 = [1,0,0;  cc,1,0;
        round(-(G3[1,1]+cc*(2*G3[1,2]+G3[2,2]*cc))/2/G3[1,3]),
        round(-(G3[1,2]+cc*G3[2,2])/G3[1,3]),1];
return([U3~*G3*U3,red[2]*U1*U2*U3]);
}
{completebasis(v,redflag=0) =
\\ Gives a unimodular matrix with the last column equal to v.
\\ If redflag <> 0, then the first columns are reduced.

local(U,n,re);

  v = Mat(v);
  n = length(v~);
  if( n == length(v), return(v));
  U = (mathnf(v~,1)[2]~)^-1;
  if( n==1 || !redflag, return(U));
  re = qflll(vecextract(U,1<<n-1,1<<(n-#v)-1));
return( U*matdiagonalblock([re,matid(#v)]));
}
{LLLgoon(G,c=1) =
\\ LLL reduction of the quadratic form G (Gram matrix)
\\ where we go on, even if an isotropic vector is found.

local(red,U1,G2,U2,G3,n,U3,G4,U,V,B,U4,G5,U5,G6);

  red = IndefiniteLLL(G,c,1);
\\ If no isotropic vector is found, nothing to do.
  if( length(red) == 2, return(red));
\\ otherwise:
  U1 = red[2];
  G2 = red[1]; \\ On a G2[1,1] = 0
  U2 = mathnf(Mat(G2[1,]),4)[2];
  G3 = U2~*G2*U2;
\\ The first line of the matrix G3 only contains 0,
\\ except some 'g' on the right, where g^2| det G.
  n = length(G);
  U3 = matid(n); U3[1,n] = round(-G3[n,n]/G3[1,n]/2);
  G4 = U3~*G3*U3;
\\ The coeff G4[n,n] is reduced modulo 2g
  U = vecextract(G4,[1,n],[1,n]);
  if( n == 2,
    V = matrix(2,0)
  , V = vecextract(G4,[1,n],1<<(n-1)-2));
  B = round(-U^-1*V);
  U4 = matid(n);
  for( j = 2, n-1,
    U4[1,j] = B[1,j-1];
    U4[n,j] = B[2,j-1]
  );
  G5 = U4~*G4*U4;
\\ The last column of G5 is reduced
  if( n < 4, return([G5,U1*U2*U3*U4]));

  red = LLLgoon(matrix(n-2,n-2,i,j,G5[i+1,j+1]),c);
  U5 = matdiagonalblock([Mat(1),red[2],Mat(1)]);
  G6 = U5~*G5*U5;
return([G6,U1*U2*U3*U4*U5]);
}
{myhilbert(a,b,p) =
\\ Compute the hilbert symbol at p
\\ where p = -1 means real place and not p = 0 as in gp
  if( sign(p) < 0, hilbert(a,b,0), hilbert(a,b,p));
}
{QfWittinvariant(G,p) =
\\ Compute the c-invariant (=Witt invariant) of a quadratic form
\\ at a prime (real place if p = -1)

local(n,vdet,diag,c);

  n = length(G);
\\ Diagonalize G first.
  vdet  = vector( n+1, i, matdet(matrix(i-1,i-1,j,k,G[j,k])));
  diag = vector( n, i, vdet[i+1]/vdet[i]);

\\ Then compute Hilbert symbols
  c = prod( i = 1, n,
        prod( j = i+1, n,
          myhilbert( diag[i], diag[j], p)));
return(c);
}
{Qflisteinvariants(G,fa=[]) =
\\ G is a quadratic form, or a symmetrix matrix,
\\ or a list of quadratic forms with the same discriminant.
\\ If given, fa must be equal to factor(-abs(2*matdet(G)))[,1].

local(l,sol,n,vdet);

if( DEBUGLEVEL_qfsolve >= 4, print("    starting Qflisteinvariants ",G));
  if( type(G) != "t_VEC", G = [G]);
  l = length(G);
  for( j = 1, l,   
    if( type(G[j]) == "t_QFI" || type(G[j]) == "t_QFR", 
      G[j] = mymat(G[j])));

  if( !length(fa), 
    fa = factor(-abs(2*matdet(G[1])))[,1]);

  if( length(G[1]) == 2, 
\\ In dimension 2, each invariant is a single Hilbert symbol.
    vdet = -matdet(G[1]);
    sol = matrix(length(fa),l,i,j,myhilbert(G[j][1,1],vdet,fa[i])<0);
if( DEBUGLEVEL_qfsolve >= 4, print("    end of Qflisteinvariants"));
    return([fa,sol])
  );

  sol = matrix(length(fa),l);
  for( j = 1, l,
    n = length(G[j]);
\\ In dimension n, we need to compute a product of n Hilbert symbols.
    vdet = vector(n+1, i, matdet(matrix(i-1,i-1,k,m,G[j][k,m])));
    for( i = 1, length(fa),
      sol[i,j] = prod( k = 1, n-1, myhilbert(-vdet[k],vdet[k+1],fa[i]))*myhilbert(vdet[n],vdet[n+1],fa[i]) < 0;
    )
  );
if( DEBUGLEVEL_qfsolve >= 4, print("    end of Qflisteinvariants"));
return([fa,sol]);
}
{Qfsolvemodp(G,p) =
\\ p a prime number. 
\\ finds a solution mod p for the quadatic form G
\\ such that det(G) !=0 mod p and dim G = n>=3;
local(n,vdet,G2,sol,x1,x2,x3,N1,N2,N3,s,r);

  n = length(G);
  vdet = [0,0,0];
  for( i = 1, 3,
    G2 = vecextract(G,1<<i-1,1<<i-1)*Mod(1,p);
    if( !(vdet[i] = matdet(G2)),
      sol = kermodp(lift(G2),p)[2][,1];
      sol = vectorv(n, j, if( j <= i, sol[j], 0));
      return(sol)
    )
  );

\\ now, solve in dimension 3...
\\ reduction to the diagonal case:

  x1 = [1,0,0]~;
  x2 = [-G2[1,2],G2[1,1],0]~;
  x3 = [G2[2,2]*G2[1,3]-G2[2,3]*G2[1,2],G2[1,1]*G2[2,3]-G2[1,3]*G2[1,2],G2[1,2]^2-G2[1,1]*G2[2,2]]~;
  while(1,
    if( issquare( N1 = -vdet[2]),                 s = sqrt(N1); sol = s*x1+x2; break);
    if( issquare( N2 = -vdet[3]/vdet[1]),         s = sqrt(N2); sol = s*x2+x3; break);
    if( issquare( N3 = -vdet[2]*vdet[3]/vdet[1]), s = sqrt(N3); sol = s*x1+x3; break);
    r = 1;
    while( !issquare( s = (1-N1*r^2)/N3), r = random(p));
    s = sqrt(s); sol = x1+r*x2+s*x3; break
  );
  sol = vectorv(n, j, if( j <= 3, sol[j]));
return(sol);
}
{Qfminim(G,factdetG=0) =
\\ Minimization of the quadratic form G, with nonzero determinant.
\\ of dimension n>=2. 
\\ G must by symmetric and have integral coefficients.
\\ Returns [G',U,factd] with U in GLn(Q) such that G'=U~*G*U*constant
\\ is integral and has minimal determinant.
\\ In dimension 3 or 4, may return a prime p
\\ if the reduction at p is impossible because of the local non solvability.
\\ If given, factdetG must be equal to factor(abs(det(G))).
local(n,factd,detG,i,U,vp,Ker,dimKer,Ker2,dimKer2,sol,aux,p,di,m);

  n = length(G);
  factd = matrix(0,2);
  if( !factdetG,
    detG = matdet(G);
    factdetG = factor(detG)
  );

  i = 1; U = matid(n);
  while(i <= length(factdetG[,1]),
    p = factdetG[i,1];
    if( p == -1, i++; next);
    vp = factdetG[i,2];
if( DEBUGLEVEL_qfsolve >= 4, print("    p = ",p,"^",vp));
    if( vp == 0, i++; next);
\\ The case vp = 1 can be minimized only if n is odd.
    if( vp == 1 && n%2 == 0,
      factd = concat(factd~, Mat([p,1])~)~;
      i++; next
    );
    Ker = kermodp(G,p); dimKer = Ker[1]; Ker = Ker[2];
\\ Rem: we must have dimKer <= vp
if( DEBUGLEVEL_qfsolve >= 4, print("    dimKer = ",dimKer));
\\ trivial case: dimKer = n
    if( dimKer == n, 
if( DEBUGLEVEL_qfsolve >= 4, print("     case 0: dimKer = n"));
      G /= p;
      factdetG[i,2] -= n;
      next
    );
    G = Ker~*G*Ker;
    U = U*Ker;
\\ 1st case: dimKer < vp
\\ then the kernel mod p contains a kernel mod p^2
    if( dimKer < vp,
if( DEBUGLEVEL_qfsolve >= 4, print("    case 1: dimker < vp"));
      Ker2 = kermodp(matrix(dimKer,dimKer,j,k,G[j,k]/p),p);
      dimKer2 = Ker2[1]; Ker2 = Ker2[2];
      for( j = 1, dimKer2, Ker2[,j] /= p);
      Ker2 = matdiagonalblock([Ker2,matid(n-dimKer)]);
      G = Ker2~*G*Ker2;
      U = U*Ker2;
      factdetG[i,2] -= 2*dimKer2;
if( DEBUGLEVEL_qfsolve >= 4, print("    end of case 1"));
      next
    );

\\ Now, we have vp = dimKer 
\\ 2nd case: the dimension of the kernel is >=2
\\ and contains an element of norm 0 mod p^2
    if( dimKer > 2 || 
       (dimKer == 2 && issquare(di=Mod((G[1,2]^2-G[1,1]*G[2,2])/p^2,p))),
\\ search for an element of norm p^2... in the kernel
      if( dimKer > 2,
if( DEBUGLEVEL_qfsolve >= 4, print("    case 2.1"));
        dimKer = 3;
        sol = Qfsolvemodp(matrix(3,3,j,k,G[j,k]/p),p)
      ,  
if( DEBUGLEVEL_qfsolve >= 4, print("    case 2.2"));
        if( G[1,1]%p^2 == 0, 
          sol = [1,0]~
        , sol = [-G[1,2]/p+sqrt(di),Mod(G[1,1]/p,p)]~
        )
      );
      sol = centerlift(sol); sol /= content(sol);
if( DEBUGLEVEL_qfsolve >= 4, print("    sol = ",sol));
      Ker = vectorv(n, j, if( j<= dimKer, sol[j], 0)); \\ fill with 0's
      Ker = completebasis(Ker,1);
      Ker[,n] /= p;
      G = Ker~*G*Ker;
      U = U*Ker;
      factdetG[i,2] -= 2;
if( DEBUGLEVEL_qfsolve >= 4, print("    end of case 2"));
      next
    );

\\ Now, we have vp = dimKer <= 2 
\\   and the kernel contains no vector with norm p^2...

\\ In some cases, exchanging the kernel and the image
\\ makes the minimization easy.

    m = (n-1)\2-1;
    if( ( vp == 1 && issquare(Mod(-(-1)^m*matdet(G)/G[1,1],p)))
     || ( vp == 2 && n%2 == 1 && n >= 5)
     || ( vp == 2 && n%2 == 0 && !issquare(Mod((-1)^m*matdet(G)/p^2,p)))
    , 
if( DEBUGLEVEL_qfsolve >= 4, print("    case 3"));
      Ker = matid(n);
      for( j = dimKer+1, n, Ker[j,j] = p);
      G = Ker~*G*Ker/p;
      U = U*Ker;
      factdetG[i,2] -= 2*dimKer-n;
if( DEBUGLEVEL_qfsolve >= 4, print("    end of case 3"));
      next
    );

\\ Minimization was not possible se far.
\\ If n == 3 or 4, this proves the local non-solubility at p.
    if( n == 3 || n == 4, 
if( DEBUGLEVEL_qfsolve >= 1, print(" no local solution at ",p));
      return(p));

if( DEBUGLEVEL_qfsolve >= 4, print("    prime ",p," finished"));
    factd = concat(factd~,Mat([p,vp])~)~;
    i++
  );
\\ apply LLL to avoid coefficients explosion
  aux = qflll(U);
return([aux~*G*aux,U*aux,factd]);
}
{mymat(qfb) = qfb = Vec(qfb);[qfb[1],qfb[2]/2;qfb[2]/2,qfb[3]];
}
{Qfbsqrtgauss(G,factdetG) =
\\ Compute the square root of the quadratic form G.
\\ This function is not fully implemented.
\\ For the moment it only works for detG squarefree
\\ (except at 2, where the valuation is 2 or 3).
\\ factdetG must be given and is equal to factor(2*abs(det G))
local(a,b,c,d,m,n,p,aux,Q1,M);

if( DEBUGLEVEL_qfsolve >=3, print("   starting Qfbsqrtgauss with ",G,factdetG));
  G = Vec(G);
  a = G[1]; b = G[2]/2; c = G[3]; d = a*c-b^2;

\\ 1st step: solve m^2 = a (d), m*n = -b (d), n^2 = c (d)
  m = n = Mod(1,1);
  factdetG[1,2] -= 3;
  for( i = 1, length(factdetG[,1]),
    if( !factdetG[i,2], next);
    p = factdetG[i,1];
    if( gcd(a,p) == 1,
      aux = sqrt(Mod(a,p));
      m = chinese(m,aux);
      n = chinese(n,-b/aux)
    ,
      aux = sqrt(Mod(c,p));
      n = chinese(n,aux);
      m = chinese(m,-b/aux)
    )
  );
  m = centerlift(m);  n = centerlift(n);
if( DEBUGLEVEL_qfsolve >=4, print("    m = ",m); print("    n = ",n));
  
\\ 2nd step: build Q1, with det=-1 such that Q1(x,y,0) = G(x,y)
  Q1 = [(n^2-c)/d, (m*n+b)/d, n ;
        (m*n+b)/d, (m^2-a)/d, m ;
        n,         m,         d ];
  Q1 = -matadjoint(Q1);

\\ 3rd step: reduce Q1 to [0,0,-1;0,1,0;-1,0,0]
  M = LLLgoon3(Q1)[2][3,];
  if( M[1] < 0, M = -M);
if( DEBUGLEVEL_qfsolve >=3, print("   end of Qfbsqrtgauss"));
  if( M[1]%2,
    return(Qfb(M[1],2*M[2],2*M[3]))
  , return(Qfb(M[3],-2*M[2],2*M[1])));
}
{class2(D,factdetG,Winvariants,U2) =
\\ Implementation of Shanks/Bosma-Stevenhagen algorithm
\\ to compute the 2-Sylow of the class group of discriminant D.
\\ Only works for D = fundamental discriminant.
\\ When D = 1(4), work with 4D.
\\ If given, factdetG must be equal to factor(abs(2*D)).
\\ Apart from this factorization, the algorithm is polynomial time.
\\ If Winvariants is given, the algorithm stops as soon as
\\ an element having these W-invariants is found.
local(factD,n,rang,m,listgen,vD,p,vp,aux,invgen,im,Ker,Kerim,listgen2,G2,clgp2,E,red);

if( DEBUGLEVEL_qfsolve >= 1, print(" Construction of the 2-class group of discriminant ",D));
  if( D%4 == 2 || D%4 == 3, error("class2: Discriminant not congruent to 0,1 mod 4"));

  if( D==-4, return([[1],[Qfb(1,0,1)]]));

  if( !factdetG, factdetG = factor(2*abs(D)));
  factD = concat([-1],factdetG[,1]~);
  if( D%4 == 1, D *= 4; factdetG[1,2] += 2);
  
  n = length(factD); rang = n-3;
  if(D>0, m = rang+1, m = rang);
  if(m<0, m=0);
if( DEBUGLEVEL_qfsolve >= 3, print("   factD = ",factD));
  listgen = vector(m);
  
  if( vD = valuation(D,2),
    E = Qfb(1,0,-D/4)
  , E = Qfb(1,1,(1-D)/4)
  );
if( DEBUGLEVEL_qfsolve >= 3, print("   E = ",E));

  if( type(Winvariants) == "t_COL" && (Winvariants == 0 || length(matinverseimage(U2*Mod(1,2),Winvariants))>0), return([[1],[E]]));
  
  for( i = 1, m, \\ no need to look at factD[1]=-1, nor factD[2]=2
    p = factD[i+2];
    vp = valuation(D,p);
    aux = p^vp;
    if( vD,
      listgen[i] = Qfb(aux,0,-D/4/aux)
    , listgen[i] = Qfb(aux,aux,(aux-D/aux)/4))
  );
  if( vD == 2 && D%16 != 4,
    m++; rang++; listgen = concat(listgen,[Qfb(2,2,(4-D)/8)]));
  if( vD == 3,
    m++; rang++; listgen = concat(listgen,[Qfb(2^(vD-2),0,-D/2^vD)]));
  
if( DEBUGLEVEL_qfsolve >= 3, print("   listgen = ",listgen));
if( DEBUGLEVEL_qfsolve >= 2, print("  rank = ",rang));

  if( !rang, return([[1],[E]]));

 invgen = Qflisteinvariants(listgen,factD)[2]*Mod(1,2);
if( DEBUGLEVEL_qfsolve >= 3, print("   invgen = ",lift(invgen)));

  clgp2 = vector(m,i,2);
  im = lift(matinverseimage(invgen,matimage(invgen)));
  while( (length(im) < rang) 
  || (type(Winvariants) == "t_COL" && length(matinverseimage(concat(invgen,U2),Winvariants) == 0)), 
    Ker = lift(matker(invgen));
    Kerim = concat(Ker,im);
    listgen2 = vector(m);
    for( i = 1, m,
      listgen2[i] = E;
      for( j = 1, m,
        if( Kerim[j,i],
          listgen2[i] = qfbcompraw(listgen2[i],listgen[j])));
      if( norml2(Kerim[,i]) > 1,
        red = QfbReduce(aux=mymat(listgen2[i]));
        aux = red~*aux*red;
        listgen2[i] = Qfb(aux[1,1],2*aux[1,2],aux[2,2]))
    );
    listgen = listgen2;
    invgen = invgen*Kerim;

if( DEBUGLEVEL_qfsolve >= 4, print("    listgen = ",listgen));
if( DEBUGLEVEL_qfsolve >= 4, print("    invgen = ",lift(invgen)));

    for( i = 1, length(Ker),
      G2 = Qfbsqrtgauss(listgen[i],factdetG);
      clgp2[i] <<= 1;
      listgen[i] = G2;
      invgen[,i] = Qflisteinvariants(G2,factD)[2][,1]*Mod(1,2)
    );

if( DEBUGLEVEL_qfsolve >= 3, print("   listgen = ",listgen));
if( DEBUGLEVEL_qfsolve >= 3, print("   invgen = ",lift(invgen)));
if( DEBUGLEVEL_qfsolve >= 3, print("   clgp2 = ",clgp2));

    im = lift(matinverseimage(invgen,matimage(invgen)))
  );
 
  listgen2 = vector(rang);
  for( i = 1, rang,
    listgen2[i] = E;
    for( j = 1, m,
      if( im[j,i],
        listgen2[i] = qfbcompraw(listgen2[i],listgen[j])));
    if( norml2(im[,i]) > 1,
      red = QfbReduce(aux=mymat(listgen2[i]));
      aux = red~*aux*red;
      listgen2[i] = Qfb(aux[1,1],2*aux[1,2],aux[2,2]))
  );
  listgen = listgen2;
\\ listgen = vector(rang,i,listgen[m-rang+i]);
  clgp2 = vector(rang,i,clgp2[m-rang+i]);

if( DEBUGLEVEL_qfsolve >= 2, print("  listgen = ",listgen));
if( DEBUGLEVEL_qfsolve >= 2, print("  clgp2 = ",clgp2));

return([clgp2,listgen]);
}
{Qfsolve(G,factD) =
\\ Given a square matrix G of dimension n >= 1,
\\ solves over Z the quadratic equation X^tGX = 0.
\\ G is assumed to have integral coprime coefficients.
\\ The solution might be a vectorv or a matrix.
\\ If no solution exists, returns an integer, that can
\\ be a prime p such that there is no local solution at p,
\\ or -1 if there is no real solution,
\\ or 0 in some rare cases.
\\
\\ If given, factD must be equal to factor(-abs(2*matdet(G))).

local(n,M,signG,d,Min,U,codim,aux,G1,detG1,M1,subspace1,G2,subspace2,M2,solG2,Winvariants,dQ,factd,U2,clgp2,V,detG2,dimseti,solG1,sol,Q);

if( DEBUGLEVEL_qfsolve >= 1, print(" starting Qfsolve"));

  if( type(G) != "t_MAT", error(" wrong type in Qfsolve: should be a t_MAT"));
  n = matsize(G);
  if( n[1] != n[2], error(" not a square matrix in Qfsolve"));
  n = length(G);
  if( n == 0, error(" dimension should be > 0"));

\\ Trivial case: det = 0

  d = matdet(G);
  if( d == 0,
if( DEBUGLEVEL_qfsolve >= 1, print(" trivial case: det = 0"));
    return(matker(G)));

\\ Small dimension: n <= 2

  if( n == 1,
if( DEBUGLEVEL_qfsolve >= 1, print(" trivial case: dim = 1"));
    return(0));
  if( n == 2,
if( DEBUGLEVEL_qfsolve >= 1, print(" trivial case: dim = 2"));
    if( !issquare(-d), return(0));
    di = sqrtint(-d);
    return([-G[1,2]+di,G[1,1]]~)
  );

\\
\\ 1st reduction of the coefficients of G
\\

  M = IndefiniteLLL(G);
  if( type(M) == "t_COL",
if( DEBUGLEVEL_qfsolve >= 1, print(" solution ",M));
if( DEBUGLEVEL_qfsolve >= 1, print(" end of Qfsolve"));
    return(M));
  G = M[1]; M = M[2];

\\ Real solubility
  signG = qfsign(G);
  if( signG[1] == 0 || signG[2] == 0,
if( DEBUGLEVEL_qfsolve >= 1, print(" no real solution"));
if( DEBUGLEVEL_qfsolve >= 1, print(" end of Qfsolve"));
    return(-1));
  if( signG[1] < signG[2], G = -G; signG = signG*[0,1;1,0]);

\\ Factorization of the determinant
  if( !factD, 
if( DEBUGLEVEL_qfsolve >= 1, print1(" factorization of the determinant = "));
    factD = factor(-abs(2*d));
    factD[1,2] = 0;
    factD[2,2] --;
if( DEBUGLEVEL_qfsolve >= 1, print(factD))
  );

\\
\\ Minimization and local solubility
\\

if( DEBUGLEVEL_qfsolve >= 1, print(" minimization of the determinant"));
  Min = Qfminim(G,factD);
  if( type(Min) == "t_INT",
if( DEBUGLEVEL_qfsolve >= 1, print(" no local solution at ",Min));
if( DEBUGLEVEL_qfsolve >= 1, print(" end of Qfsolve"));
    return(Min));

  M = M*Min[2];
  G = Min[1];
\\  Min[3] contains the factorization of abs(matdet(G));

if( DEBUGLEVEL_qfsolve >= 4, print("    G minim = ",G));
if( DEBUGLEVEL_qfsolve >= 4, print("    d = ",d));

\\ Now, we know that local solutions exist
\\ (except maybe at 2 if n==4),
\\ if n==3, det(G) = +-1
\\ if n==4, or n is odd, det(G) is squarefree.
\\ if n>=6, det(G) has all its valuations <=2.

\\ Reduction of G and search for trivial solutions.
\\ When det G=+-1, such trivial solutions always exist.

if( DEBUGLEVEL_qfsolve >= 1, print(" reduction"));
  U = IndefiniteLLL(G);
  if(type(U) == "t_COL",
if( DEBUGLEVEL_qfsolve >= 1, print(" solution = ",M*U));
if( DEBUGLEVEL_qfsolve >= 1, print(" end of Qfsolve"));
    return(M*U));
  G = U[1]; M = M*U[2];

\\
\\ If n >= 6 is even, need to increment the dimension by 1
\\ to suppress all the squares of det(G).
\\

  if( n >= 6 && n%2 == 0 && matsize(Min[3])[1] != 0,
if( DEBUGLEVEL_qfsolve >= 1, print(" increase the dimension by 1 = ",n+1));
    codim = 1; n++;
\\ largest square divisor of d.
    aux = prod( i = 1, matsize(Min[3])[1], if( Min[3][i,1] == 2, Min[3][i,1], 1));
\\ Choose the sign of aux such that the signature of G1
\\ is as balanced as possible
    if( signG[1] > signG[2],
      signG[2] ++; aux = -aux
    , signG[1] ++
    );
    G1 = matdiagonalblock([G,Mat(aux)]);
    detG1 = 2*matdet(G1);
    for( i = 2, length(factD[,1]),
      factD[i,2] = valuation(detG1,factD[i,1]));
    factD[2,2]--;
    Min = Qfminim(G1,factD);
    G1 = Min[1];
    M1 = Min[2];
    subspace1 = matrix(n,n-1,i,j, i == j)
  , codim = 0;
    G1 = G;
    subspace1 = M1 = matid(n)
  );
\\ Now, d is squarefree

\\ 
\\ If d is not +-1, need to increment the dimension by 2
\\

  if( matsize(Min[3])[1] == 0, \\ if( abs(d) == 1,
if( DEBUGLEVEL_qfsolve >= 2, print("  detG2 = 1"));
     G2 = G1;
     subspace2 = M2 = matid(n);
     solG2 = LLLgoon(G2,1)
  ,
if( DEBUGLEVEL_qfsolve >= 1, print(" increase the dimension by 2 = ",n+2));
    codim += 2;
    subspace2 = matrix( n+2, n, i, j, i == j);
    d = prod( i = 1, matsize(Min[3])[1],Min[3][i,1]);    \\ d = abs(matdet(G1));
    if( signG[2]%2 == 1, d = -d);                        \\ d = matdet(G1);
    if( Min[3][1,1] == 2, factD = [-1], factD = [-1,2]); \\ if d is even ...
    factD = concat(factD, Min[3][,1]~);
if( DEBUGLEVEL_qfsolve >= 4, print("    factD = ",factD));

\\ Solubility at 2 (this is the only remaining bad prime).
    if( n == 4 && d%8 == 1,
      if( QfWittinvariant(G,2) == 1,
if( DEBUGLEVEL_qfsolve >= 1, print(" no local solution at 2"));
if( DEBUGLEVEL_qfsolve >= 1, print(" end of Qfsolve"));
        return(2)));
  
\\
\\ Build a binary quadratic form with given invariants
\\
    Winvariants = vectorv(length(factD));

\\ choose the signature of Q.
\\ (real invariant and sign of the discriminant)
    dQ = abs(d);
    if( signG[1] ==signG[2], dQ = dQ; Winvariants[1] = 0); \\ signQ = [1,1];
    if( signG[1] > signG[2], dQ =-dQ; Winvariants[1] = 0); \\ signQ = [2,0];
    if( n == 4 && dQ%4 != 1, dQ *= 4);
    if( n >= 5, dQ *= 8);

\\ p-adic invariants
\\ for p = 2, the choice is fixed from the product formula
    if( n == 4, 
if( DEBUGLEVEL_qfsolve >= 1, print(" compute the local invariants of G1"));
      aux = Qflisteinvariants(-G1,factD)[2][,1];
      for( i = 3, length(factD), Winvariants[i] = aux[i])
    ,
      aux = (-1)^((n-3)/2)*dQ/d; \\ ici aux = 8 ou -8
      for( i = 3, length(factD), Winvariants[i] = myhilbert(aux,factD[i],factD[i]) > 0)
    );
    Winvariants[2] = sum( i = 1, length(factD), Winvariants[i])%2;

if( DEBUGLEVEL_qfsolve >= 1,
  print(" Search for a binary quadratic form of discriminant = ",dQ);
  print(" and Witt invariants = ",Winvariants));

\\ Construction of the 2-class group of discriminant dQ
\\ until some product of the generators gives the desired invariants.
\\ In dim 4, need to look among the form of the type q or 2*q
\\ because Q might be imprimitive.

    factd = matrix(length(factD)-1,2);
    for( i = 1, length(factD)-1,
      factd[i,1] = factD[i+1];
      factd[i,2] = valuation(dQ,factd[i,1]));
    factd[1,2]++;
    U2 = matrix(length(factD), n == 4, i,j, myhilbert(2,dQ,factD[i])<0);
    clgp2 = class2(dQ,factd,Winvariants,U2);
if( DEBUGLEVEL_qfsolve >= 4, print("    clgp2 = ",clgp2));

    clgp2 = clgp2[2];
    U = Qflisteinvariants(clgp2,factD)[2];
    if( n == 4, U = concat(U,U2));
if( DEBUGLEVEL_qfsolve >= 4, print("    U = ",U));

    V = lift(matinverseimage(U*Mod(1,2),Winvariants*Mod(1,2)));
if( DEBUGLEVEL_qfsolve >= 4, print("    V = ",V));

    if( dQ%2 == 1, Q = qfbprimeform(4*dQ,1), Q = qfbprimeform(dQ,1));
    for( i = 1, length(clgp2), 
      if( V[i], Q = qfbcompraw(Q,clgp2[i])));
    Q = mymat(Q);
    if( norml2(V) > 1, aux = QfbReduce(Q); Q = aux~*Q*aux);
    if( n == 4 && V[length(V)], Q*=  2);
if( DEBUGLEVEL_qfsolve >= 2, print("  Q = ",Q));
if( DEBUGLEVEL_qfsolve >= 3, print("   Witt invariants of Q = ",Qflisteinvariants(Q,factD)));

\\
\\ Build a form of dim=n+2 potentially unimodular
\\

    G2 = matdiagonalblock([G1,-Q]);
if( DEBUGLEVEL_qfsolve >= 4, print("    G2 = ",G2));

if( DEBUGLEVEL_qfsolve >= 2, print("  minimization of the form of dimension ",length(G2)));
\\ Minimization of G2
    detG2 = matdet(G2);
    factd = matrix(length(factD)-1,2);
    for( i = 1, length(factD)-1,
      factd[i,2] = valuation(detG2, factd[i,1] = factD[i+1]));
if( DEBUGLEVEL_qfsolve >= 3, print("   det(G2) = ",factd));
    Min = Qfminim(G2,factd);
    M2 = Min[2]; G2 = Min[1];
if( abs(matdet(G2)) > 2, error("Qfsolve: det(G2) <> +-1 *******"));
if( DEBUGLEVEL_qfsolve >= 4, print("    G2 = ",G2));

\\ Now, we have det(G2) = +-1

\\ Find a seti for G2 (Totally isotropic subspace, Sous-Espace Totalement Isotrope)
if( DEBUGLEVEL_qfsolve >= 2, print("  Search a subspace of solutions for G2"));
    solG2 = LLLgoon(G2,1);
    if( matrix(codim+1,codim+1,i,j,solG2[1][i,j]) != 0,
      error("Qfsolve: not enough solutions in G2"));
  );

\\ G2 must have a subspace of solutions of dimension > codim
  dimseti = 0;
  while( matrix(dimseti+1,dimseti+1,i,j,solG2[1][i,j]) == 0, dimseti ++);
  if( dimseti <= codim,
    error("Qfsolve: not enough solutions for G2"));
  solG2 = matrix(length(G2),dimseti,i,j,solG2[2][i,j]);
if( DEBUGLEVEL_qfsolve >= 3, print("   solG2 = ",solG2));

\\ The solution of G1 is simultaneously in solG2 and subspace2
if( DEBUGLEVEL_qfsolve >= 1, print(" Reconstruction of a solution of G1"));
  solG1 = matintersect(subspace2,M2*solG2);
  solG1 = subspace2~*solG1;
if( DEBUGLEVEL_qfsolve >= 3, print("   solG1 = ",solG1));

\\ The solution of G is simultaneously in solG and subspace1
if( DEBUGLEVEL_qfsolve >= 1, print(" Reconstruction of a solution of G"));
  sol = matintersect(subspace1,M1*solG1);
  sol = subspace1~*sol;
  sol = M*sol;
  sol /= content(sol);
  if( length(sol) == 1, sol = sol[,1]);
if( DEBUGLEVEL_qfsolve >= 3, print("   sol = ",sol));
if( DEBUGLEVEL_qfsolve >= 1, print(" end of Qfsolve"));
  return(sol);
}
{matdiagonalblock(v) =
local(lv,lt,M);
  lv = length(v);
  lt = sum( i = 1, lv, length(v[i]));
  M = matrix(lt,lt);
  lt = 0;
  for( i = 1, lv,
    for( j = 1, length(v[i]),
      for( k = 1, length(v[i]),
        M[lt+j,lt+k] = v[i][j,k]));
    lt += length(v[i])
  );
return(M);
}

\\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\\            HELP MESSAGES                \\
\\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

{
addhelp(default_qfsolve,
  "default_qfsolve(DEBUGLEVEL_qfsolve):
  output/set the value of the global variable DEBUGLEVEL_qfsolve.
  The higher the value, the more information you get about intermediate
  results concerning functions related to Qfsolve.
  default is 0: print nothing.");
addhelp(Qfsolve,
  "Given a square matrix G of dimension n >= 1,
  solves over Z the quadratic equation X^tGX = 0.
  G is assumed to have integral coprime coefficients.
  The solution might be a vectorv or a matrix.
  If no solution exists, returns an integer, that can
  be a prime p such that there is no local solution at p,
  or -1 if there is no real solution,
  or 0 in some rare cases.
  If given, factD must be equal to factor(-abs(2*matdet(G))).
");

}





