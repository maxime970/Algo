# Explication des algorithmes

## Naive:

Complexit�: $O(n^2)$

L'algorithme prend en entr�e un tableau v de doubles � une dimension 
et retourne le sous tableau de somme maximale

Nous utilisons une borne inf (start) et une borne sup (end) afin de 
d�limiter le sous tableau de taille maximale

Nous testons tout simplement toutes les combinaisons possibles de sous tableau
et nous gardons en m�moire le maximum trouv�.
Nous retournons finalement le maximum.



## Kadane:

Complexit�: $O(n)$
L'algorithme prend en entr�e un tableau v de doubles � une dimension 
et retourne le sous tableau de somme maximale
Nous parcourons une seule fois la liste.
Nous utilisons un maximum local (max) et un maximum global (globalMax) ainsi 
qu'une borne inf et une borne sup afin de renseigner la position du
sous tableau de somme maximale.

Pour tout i dans [1:n]:

si v[i] > v[i] + max
on en d�duit que la borne inf doit �tre avanc�e car l'�l�ment actuel est plus grand 
que la somme du sous tableau allant de la borne inf � l'�l�ment actuel.
on d�finit donc la nouvelle borne inf � l'�l�ment actuel (borne inf = i)
on d�finit donc le nouveau max local comme �tant la valeur de l'�l�ment actuel (max = v[i])

si ce n'est pas le cas:
c'est que le max local peut �tre encore augment� donc on garde notre borne inf actuelle et 
nous ajoutons l'�l�ment actuel au max (max = max + v[i])

si notre globalMax <= max
nous devons garder en m�moire le plus grand max local (globalMax = max)
nous devons �galement actualiser la nouvelle borne sup (borne sup = i)

nous avons parcouru toute la liste et nous avons v�rifier � chaque fois si l'on
pouvais trouver un sous tableau plus grand que celui d�finit au d�but
finalement nous retournons la valeur du maximum global.