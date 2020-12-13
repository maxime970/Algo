Kadane:

Complexité: O(n)
L'algorithme prends en entrée un tableau v de doubles à une dimension 
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



