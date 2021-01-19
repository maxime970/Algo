#include <Rcpp.h>

using namespace Rcpp;

// [[Rcpp::export]]
NumericVector naive_cpp(NumericVector v)
{
  // Complexité: O(n^2)
  // L'algorithme prend en entrée un tableau v d'entiers à une dimension et retourne le sous tableau de somme maximale
  // Nous testons tout simplement toutes les combinaisons possibles de sous tableau et nous gardons en mémoire le maximum trouvé. Nous retournons finalement le maximum.
  int n = v.length();
  int start = 0;// Nous utilisons une borne inf (start) et une borne sup (end) afin de délimiter le sous tableau de taille maximale
  int end = 0;
  int max = INT_MIN;
  for (int i=0; i<n; i++) // deux boucles successives pour essayer toutes les possibilités
  {
    int runningSum = 0;
    for (int j=i; j<n; j++)
    {
      runningSum += v[j];
      if (runningSum >= max)
      {
        max = runningSum;
        start = i;
        end = j;
      }
    }
  }
  NumericVector res = NumericVector::create(_["max"]=max, _["start"]=start, _["end"]=end);
  return res;
}

// [[Rcpp::export]]
NumericVector kadane_cpp(NumericVector v) 
{
  // Complexité: O(n)
  // L'algorithme prend en entrée un tableau v de d'entiers à une dimension et retourne le sous tableau de somme maximale. Nous parcourons une seule fois la liste. Nous utilisons un maximum local (localMax) et un maximum global (globalMax) ainsi qu'une borne inf (start) et une borne sup (end) afin de renseigner la position du sous tableau de somme maximale.
  //     Pour tout i dans [1:n]:
  //         On ajoute la valeur actuelle du tableau v au maximum local localMax += v[i]
  //         Si le localMax est strictement plus grand que le globalMax alors on actualise la valeur du globalMax: globalMax = localMax. On actualise également les bornes start = s et end = i.
  //         Si le localMax est strictement négative alors on sait que le sous tableau maximum ne peut pas se trouver entre 0 et i. On réinitialise donc le localMax: localMax = 0 ainsi que la nouvelle borne inf: s = i + 1
  //     Nous avons parcouru toute la liste et nous avons vérifier à chaque fois si l'on pouvais trouver un sous tableau plus grand que celui définit au début finalement nous retournons la valeur du maximum global.
  int n = v.length();
  int globalMax = INT_MIN;
  int localMax = 0;
  int start = 0;
  int end = 0;
  int s = 0; 
  
  for (int i=0; i<n; i++) 
  { 
    localMax += v[i]; // On ajoute la valeur actuelle du tableau v au maximum local localMax += v[i]
    if (localMax > globalMax) // Si le localMax est strictement plus grand que le globalMax alors on actualise la valeur du globalMax: globalMax = localMax. On actualise également les bornes start = s et end = i.
    { 
      globalMax = localMax; 
      start = s; 
      end = i; 
    } 
    if (localMax < 0) // Si le localMax est strictement négative alors on sait que le sous tableau maximum ne peut pas se trouver entre 0 et i. On réinitialise donc le localMax: localMax = 0 ainsi que la nouvelle borne inf: s = i + 1
    { 
      localMax = 0; 
      s = i + 1; 
    } 
  }
  NumericVector res = NumericVector::create(_["max"]=globalMax, _["start"]=start, _["end"]=end);
  return res;
}

// [[Rcpp::export]]
NumericVector group_positive_cpp(NumericVector v)
{
  // Complexité: O(n)
  // Input: un tableau d'entiers A de taille n >= 1

  // Output: un vecteur d'entiers B de taille m>=1, m<=n
  //     On parcourt la liste une seule fois et un renvoie un vecteur créer à partir du 1er mais en regroupant et en sommant les éléments positifs. La complexité est donc linéaire (O(n))
  //     Ce vecteur est initialisé avec le premier élément du tableau.
  //     S'il y a au fil du parcours du tableau en input deux éléments positifs successifs, le dernier élément du vecteur prend la somme des deux derniers éléments du tableau. Ainsi, si on rencontre 3 éléments positifs successifs a, b et c. Le dernier élément du vecteur prendre d'abord la valeur a+b, puis a+b+c.
  //     Sinon, on ajoute l'élément au vecteur que l'on créer.
  //     l'input {1,2,2,-2,4,4,-7} renverra donc {5,-2,8,-7}
  // Une telle fonction permet de simplifier le Max Subarray Problem puisqu'à la place de rechercher une somme d'éléments maximale, on n'effectue qu'une recherche de maximum.
  int n = v.length();
  NumericVector res;
  res.push_back(v[0]); //  Ce vecteur est initialisé avec le premier élément du tableau.
  
  for (int i=0; i<n-1; i++)
  {
    if (v[i] >= 0 && v[i+1] >= 0)//  S'il y a au fil du parcours du tableau en input deux éléments positifs successifs, le dernier élément du vecteur prend la somme des deux derniers éléments du tableau. Ainsi, si on rencontre 3 éléments positifs successifs a, b et c. Le dernier élément du vecteur prendre d'abord la valeur a+b, puis a+b+c.
    {
      int new_length = res.length();
      res[new_length-1] = res[new_length-1] + v[i+1];
    }
    else
    {
      res.push_back(v[i+1]);//  Sinon, on ajoute l'élément au vecteur que l'on créer.
    }
  }
  return res;
}

// [[Rcpp::export]]
NumericVector kadane2_cpp(NumericVector v)
{
  // On essaie de regarder si l'algorithme ci-dessus peut aider à résoudre le problème plus rapidement
  // Cet algorithme ne permet pas de trouver les indices du sous-tableau mais nous permet de tester si kadane peut être plus rapide s'il est couplé à cet algorithme
  NumericVector v_grp = group_positive_cpp(v);
  NumericVector res = kadane_cpp(v_grp);
  return res;
}