# Auteurs 

Maxime GRANDVAUX

Guillaume SHI DE MILLEVILLE

Sidiya BABAH

# Explication des algorithmes

## Naive:

Complexité: O(n^2)

L'algorithme prend en entrée un tableau v de doubles à une dimension 
et retourne le sous tableau de somme maximale

Nous utilisons une borne inf (start) et une borne sup (end) afin de 
délimiter le sous tableau de taille maximale

Nous testons tout simplement toutes les combinaisons possibles de sous tableau
et nous gardons en mémoire le maximum trouvé.
Nous retournons finalement le maximum.



## Kadane:

Complexité: O(n)

L'algorithme prend en entrée un tableau v de doubles à une dimension 
et retourne le sous tableau de somme maximale
Nous parcourons une seule fois la liste.
Nous utilisons un maximum local (max) et un maximum global (globalMax) ainsi 
qu'une borne inf et une borne sup afin de renseigner la position du
sous tableau de somme maximale.

Pour tout i dans [1:n]:

si v[i] > v[i] + max
on en déduit que la borne inf doit être avancée car l'élément actuel est plus grand 
que la somme du sous tableau allant de la borne inf à l'élément actuel.
on définit donc la nouvelle borne inf à l'élément actuel (borne inf = i)
on définit donc le nouveau max local comme étant la valeur de l'élément actuel (max = v[i])

si ce n'est pas le cas:
c'est que le max local peut être encore augmenté donc on garde notre borne inf actuelle et 
nous ajoutons l'élément actuel au max (max = max + v[i])

si notre globalMax <= max
nous devons garder en mémoire le plus grand max local (globalMax = max)
nous devons également actualiser la nouvelle borne sup (borne sup = i)

nous avons parcouru toute la liste et nous avons vérifier à chaque fois si l'on
pouvais trouver un sous tableau plus grand que celui définit au début
finalement nous retournons la valeur du maximum global.


## Maximum subarray sum

Input: un tableau d'entiers A de taille n >= 1

Output: maxSum, indxD´ebut, indxFin

1 Déclarer les variables locales currentSum, maxSum, indxDebut, indxFin puis les initialiser à 0,

Declarer 3 vecteurs de taille initiale 1 C, I, J et qui sont initialisés à 0

2 Vérifier:

(I) Si A est vide, alors:
Une exception sera renvoyée à l'utilisateur

(II) Si n == 1, alors:
return maxSum = A[1], indxDebut  = indxFin = 1

3 Sinon, pour tout i allant de 1 jusqu'à n:

currentSum+ = A[i]

(a) Si currentSum ??? 0:

currentSum = 0
Ajouter l0, indice i vecteur au J

(b) Si currentSum > 0 et maxSum >= currentSum:

Ajouter l0, indice i au vecteur C

(c) Si currentSum > maxSum:

maxSum = currentSum, Ajouter l0, indice i au vecteur I, i = i + 1.

7 A la fin des itérations: Compute indxFin, et indxDebut

indxFin = max(I)

8 indxDebut = min {min(C[C > max(J[J < indxFin])]), min(I[I > max(J[J <indxFin])])}



Vidéo proposant plusieurs approches au problème :

https://www.youtube.com/watch?v=XKu_SEDAykw


