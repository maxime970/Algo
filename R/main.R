library(microbenchmark)
library(Rcpp)
#library(devtools)
#devtools::install_github("maxime970/Algo")
#library(Algo)

#  Complexité: O(n^2)
#  L'algorithme prend en entrée un tableau v d'entiers à une dimension et retourne le sous tableau de somme maximale
#  Nous testons tout simplement toutes les combinaisons possibles de sous tableau et nous gardons en mémoire le maximum trouvé. Nous retournons finalement le maximum.

naive_r <- function(v)
{
  # Brut Force algorithm
  # complexity: O(n^2)
  # on test toutes les combinaisons possibles de sous vecteurs possibles
  max <- -Inf # Nous utilisons une borne inf (start) et une borne sup (end) afin de délimiter le sous tableau de taille maximale
  start <- 0
  end <- 0
  n <- length(v)
  for (i in 1:n) # deux boucles successives pour essayer toutes les possibilités
  {
    runningSum <- 0
    for (j in i:n)
    {
      runningSum <- runningSum + v[j]
      if (runningSum >= max){
        max <- runningSum
        start <- i
        end <- j
      }
    }
  }
  return (c("max"=max, "start"=start, "end"=end))
}



 # Complexité: O(n)
 # L'algorithme prend en entrée un tableau v de d'entiers à une dimension et retourne le sous tableau de somme maximale. Nous parcourons une seule fois la liste. Nous utilisons un maximum local (localMax) et un maximum global (globalMax) ainsi qu'une borne inf (start) et une borne sup (end) afin de renseigner la position du sous tableau de somme maximale.
 #     Pour tout i dans [1:n]:
 #         On ajoute la valeur actuelle du tableau v au maximum local localMax += v[i]
 #         Si le localMax est strictement plus grand que le globalMax alors on actualise la valeur du globalMax: globalMax = localMax. On actualise également les bornes start = s et end = i.
 #         Si le localMax est strictement négative alors on sait que le sous tableau maximum ne peut pas se trouver entre 0 et i. On réinitialise donc le localMax: localMax = 0 ainsi que la nouvelle borne inf: s = i + 1
 #     Nous avons parcouru toute la liste et nous avons vérifier à chaque fois si l'on pouvais trouver un sous tableau plus grand que celui définit au début finalement nous retournons la valeur du maximum global.

kadane_r <- function(v) 
{
  n = length(v)
  globalMax = -Inf
  localMax = 0
  start = 0
  end = 0
  s = 0 
  
  for (i in (1:n))
  { 
    localMax = localMax + v[i] # On ajoute la valeur actuelle du tableau v au maximum local localMax += v[i]
    if (localMax > globalMax) # Si le localMax est strictement plus grand que le globalMax alors on actualise la valeur du globalMax: globalMax = localMax. On actualise également les bornes start = s et end = i.
    { 
      globalMax = localMax 
      start = s 
      end = i
    } 
    if (localMax < 0) # Si le localMax est strictement négative alors on sait que le sous tableau maximum ne peut pas se trouver entre 0 et i. On réinitialise donc le localMax: localMax = 0 ainsi que la nouvelle borne inf: s = i + 1
    { 
      localMax = 0
      s = i + 1
    } 
  }
  return (c("max"=globalMax, "start"=start, "end"=end))
}


#  Complexité: O(n)
#  Input: un tableau d'entiers A de taille n >= 1
# 
#  Output: un vecteur d'entiers B de taille m>=1, m<=n
#      On parcourt la liste une seule fois et un renvoie un vecteur créer à partir du 1er mais en regroupant et en sommant les éléments positifs. La complexité est donc linéaire (O(n))
#      Ce vecteur est initialisé avec le premier élément du tableau.
#      S'il y a au fil du parcours du tableau en input deux éléments positifs successifs, le dernier élément du vecteur prend la somme des deux derniers éléments du tableau. Ainsi, si on rencontre 3 éléments positifs successifs a, b et c. Le dernier élément du vecteur prendre d'abord la valeur a+b, puis a+b+c.
#      Sinon, on ajoute l'élément au vecteur que l'on créer.
#      l'input {1,2,2,-2,4,4,-7} renverra donc {5,-2,8,-7}
#  Une telle fonction permet de simplifier le Max Subarray Problem puisqu'à la place de rechercher une somme d'éléments maximale, on n'effectue qu'une recherche de maximum.


group_positive_r <- function(v){
  # complexité linéaire
  # on parcourt la liste une fois et on regroupe et somme les éléments positifs
  res <- c(v[1]) # Ce vecteur est initialisé avec le premier élément du tableau.
  for (i in (1:(length(v)-1)))
  {
    if (v[i]>0 & v[i+1]>0) # S'il y a au fil du parcours du tableau en input deux éléments positifs successifs, le dernier élément du vecteur prend la somme des deux derniers éléments du tableau. Ainsi, si on rencontre 3 éléments positifs successifs a, b et c. Le dernier élément du vecteur prendre d'abord la valeur a+b, puis a+b+c.
    {
      res[length(res)] <- res[length(res)] + v[i+1]
    }
    else
    {
      res <- c(res, v[i+1]) # Sinon, on ajoute l'élément au vecteur que l'on créer.
    }
  }
  return(res)
}

# On essaie de regarder si l'algorithme ci-dessus peut aider à résoudre le problème plus rapidement
#  Cet algorithme ne permet pas de trouver les indices du sous-tableau mais nous permet de tester si kadane peut être plus rapide s'il est couplé à cet algorithme

kadane2_r <- function(v){
  # kadane algorithm using group_positive
  v_grp <- group_positive_r(v)
  res <- kadane_r(v_grp)
  return (res)
}

max_partial_sum_r <- function(v){
  
  currentSum = 0 # a pointer that will look over the array and evaluate the accumulated sum at each iteration
  maxSum = 0 # a variable that will help us to store the max of currentSum at each step
  I = c(0); J = c(0); C = c() # a way to keep truck on the start and the end indices of the subarray we are looking for
  # we initialize I and J with 0 to avoid -Inf returned by the max  if one of them is empty 
  
  if(length(v) == 1 & is.na(v[1]) == TRUE)
    stop("Not callable for an empty array") # we raise an exception
  
  if(length(v) == 1) 
    return(c("max"=v[1], "start"=1, "end"=1))
  
  else
  {
    for(i in 1:length(v))
    {
      currentSum = currentSum + v[i]
      
      if(currentSum <= 0)
      {
        currentSum = 0
        J = c(J, i)
      }
      
      if(currentSum > 0 & maxSum >= currentSum)
        C = c(C, i)
      
      if(maxSum < currentSum) 
      {
        maxSum = currentSum
        I = c(I, i)
      }
    }
    end = max(I)
    start = min(min(C[C>max(J[J<end])]), min(I[I>max(J[J<end])]))
    return (c("max"=maxSum, "start"=start, "end"=end))
  }
}


# benchmark(n) -> retourne les temps d'éxécutions des différents algorithmes sur un échantillon de taille n inclu dans {-n, n}.
benchmark <- function(n)
{
  v <- sample(-n:n)
  time <- microbenchmark(naive_cpp(v), naive_r(v), kadane_cpp(v), kadane_r(v), kadane2_cpp(v), kadane2_r(v), max_partial_sum_r(v))
  return (time)
}


# naive_r(v: vector) -> méthode naive en R
# naive_cpp(NumericVector v) -> méthode naive en c++
# kadane_r(v: vector) -> kadane en R
# kadane_cpp(NumericVector v) -> kadane en c++
# kadane2_r(v: vector) -> kadane en r en sommant en préalable les éléments positifs
# kadane2_cpp(NumericVector v) -> kadane en c++ en sommant en préalable les éléments positifs
# max_partial_sum_r(v: vector) -> algorithme de compléxité O(n) en R
# benchmark(n) -> retourne les temps d'éxécutions des différents algorithmes sur un échantillon de taille n inclu dans {-n, n}.
# test(n) -> retourne les résultats des différents algorithmes sur un échantillon de taille n inclu dans {-n, n}.

test <- function(n)
{
  v <- sample(-n:n)
  #print(v)
  NaiveR <- naive_r(v)
  NaiveCpp <- naive_cpp(v)
  KadaneR <- kadane_r(v)
  KadaneCpp <- kadane_cpp(v)
  Kadane2R <- kadane2_r(v)
  Kadane2Cpp <- kadane2_cpp(v)
  MaxPartialSumR <- max_partial_sum_r(v)
  print(NaiveR)
  print(NaiveCpp)
  print(KadaneR)
  print(KadaneCpp)
  print(Kadane2R)
  print(Kadane2Cpp)
  print(MaxPartialSumR)
}
