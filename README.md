# Auteurs 

Maxime GRANDVAUX

Guillaume SHI DE MILLEVILLE

Sidiya BABAH

# Explication des algorithmes

## Naive:

**Complexité**: O(n^2)

* L'algorithme prend en entrée un tableau v d'entiers à une dimension 
et retourne le sous tableau de somme maximale

* Nous utilisons une borne inf (start) et une borne sup (end) afin de 
délimiter le sous tableau de taille maximale

* Nous testons tout simplement toutes les combinaisons possibles de sous tableau
et nous gardons en mémoire le maximum trouvé.
Nous retournons finalement le maximum.



## Kadane:

**Complexité**: O(n)

* L'algorithme prend en entrée un tableau v de d'entiers à une dimension et retourne le sous tableau de somme maximale.
Nous parcourons une seule fois la liste.
Nous utilisons un maximum local (localMax) et un maximum global (globalMax) ainsi 
qu'une borne inf (start) et une borne sup (end) afin de renseigner la position du
sous tableau de somme maximale.

* Pour tout i dans [1:n]:

	* On ajoute la valeur actuelle du tableau v au maximum local localMax += v[i]

	* Si le localMax est strictement plus grand que le globalMax alors on actualise la valeur du globalMax: globalMax = localMax. On actualise également les bornes start = s et end = i.

	* Si le localMax est strictement négative alors on sait que le sous tableau maximum ne peut pas se trouver entre 0 et i. On réinitialise donc le localMax: localMax = 0 ainsi que la nouvelle borne inf: s = i + 1

* Nous avons parcouru toute la liste et nous avons vérifier à chaque fois si l'on
pouvais trouver un sous tableau plus grand que celui définit au début
finalement nous retournons la valeur du maximum global.


## Maximum subarray sum

**Input**: un tableau d'entiers A de taille n >= 1

**Output**: maxSum, indxDebut, indxFin

1. Déclarer les variables locales currentSum, maxSum, indxDebut, indxFin puis les initialiser à 0,

	* Declarer 3 vecteurs de taille initiale 1 C, I, J et qui sont initialisés à 0

2. Vérifier:

	* (I) Si A est vide, alors: Une exception sera renvoyée à l'utilisateur

	* (II) Si n == 1, alors: return maxSum = A[1], indxDebut  = indxFin = 1

3. Sinon, pour tout i allant de 1 jusqu'à n:

	* currentSum+ = A[i]

4. Si currentSum >= 0:

	* currentSum = 0
	* Ajouter l0, indice i vecteur au J

5. Si currentSum > 0 et maxSum >= currentSum:

	* Ajouter l0, indice i au vecteur C

6. Si currentSum > maxSum:

	* maxSum = currentSum, Ajouter l0, indice i au vecteur I, i = i + 1.

7. A la fin des itérations: Compute indxFin, et indxDebut

	* indxFin = max(I)

8.  indxDebut = min {min(C[C > max(J[J < indxFin])]), min(I[I > max(J[J <indxFin])])}


## Tableau concaténant et sommant les éléments positifs

**Complexité**: O(n)

**Input**: un tableau d'entiers A de taille n >= 1

**Output**: un vecteur d'entiers B de taille m>=1, m<=n

* On parcourt la liste **une seule fois** et un renvoie un vecteur créer à partir du 1er mais en regroupant et en sommant les éléments positifs. La **complexité est donc linéaire** (O(n))

* Ce vecteur est initialisé avec le premier élément du tableau. 

* S'il y a au fil du parcours du tableau en *input* deux éléments positifs successifs, le dernier élément du vecteur prend la somme des deux derniers éléments du tableau. Ainsi, si on rencontre 3 éléments positifs successifs a, b et c. Le dernier élément du vecteur prendre d'abord la valeur a+b, puis a+b+c.

* Sinon, on ajoute l'élément au vecteur que l'on créer.

* l'input {1,2,2,-2,4,4,-7} renverra donc {5,-2,8,-7}

Une telle fonction permet de simplifier le Max Subarray Problem puisqu'à la place de rechercher une somme d'éléments maximale, on n'effectue qu'une recherche de maximum.

##  Fonctions disponibles

* naive_r(v: vector) -> méthode naive en R
* naive_cpp(NumericVector v) -> méthode naive en c++
* kadane_r(v: vector) -> kadane en R
* kadane_cpp(NumericVector v) -> kadane en c++
* Kadane2_r(v: vector) -> kadane en r en sommant en préalable les éléments positifs
* Kadane2_cpp(NumericVector v) -> kadane en c++ en sommant en préalable les éléments positifs
* max_partial_sum_r(v: vector) -> algorithme de compléxité O(n) en R

* benchmark(n) -> retourne les temps d'éxécutions des différents algorithmes sur un échantillon de taille n inclu dans {-n, n}.

* test(n) -> retourne les résultats des différents algorithmes sur un échantillon de taille n inclu dans {-n, n}.


*Complément d'information :*
Vidéo proposant plusieurs approches au problème expliqué lors d'une interview "How to : Work at Google"

**https://www.youtube.com/watch?v=XKu_SEDAykw**



