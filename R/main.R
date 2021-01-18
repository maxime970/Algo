library(microbenchmark)
library(Rcpp)
#library(devtools)
#devtools::install_github("maxime970/Algo")
#library(Algo)

naive_r <- function(v)
{
  # Brut Force algorithm
  # complexity: O(n^2)
  # on test toutes les combinaisons possibles de sous vecteurs possibles
  max <- -Inf
  start <- 0
  end <- 0
  n <- length(v)
  for (i in 1:n)
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
    localMax = localMax + v[i]
    if (localMax > globalMax) 
    { 
      globalMax = localMax 
      start = s 
      end = i
    } 
    if (localMax < 0) 
    { 
      localMax = 0
      s = i + 1
    } 
  }
  return (c("max"=globalMax, "start"=start, "end"=end))
}

group_positive_r <- function(v){
  # complexité linéaire
  # on parcourt la liste une fois et on regroupe et somme les éléments positifs
  res <- c(v[1])
  for (i in (1:(length(v)-1)))
  {
    if (v[i]>0 & v[i+1]>0)
    {
      res[length(res)] <- res[length(res)] + v[i+1]
    }
    else
    {
      res <- c(res, v[i+1])
    }
  }
  return(res)
}


kadane2_r <- function(v){
  # kadane algorithm using group_positive
  v_grp <- group_positive_r(v)
  res <- kadane_r(v_grp)
  return (res)
}

max_partial_sum_r <- function(v){
  
  currentSum = 0 # a pointer that will look over the array and evaluate the accumulated sum at each iteration
  
  maxSum = 0 # a variable that will help us to store the max of currentSum at each step
  
  I = c(0); J = c(0); C =c() # a way to keep truck on the start and the end indices of the subarray we are looking for
  # we initialize I and J with 0 to avoid -Inf returned by the max  if one of them is empty 
  
  if(length(v) == 1 & is.na(v[1]) == TRUE)
    stop("Not callable for an empty array") # we raise an exception
  
  if(length(v) == 1) 
    return (c("max"=v[1], "start"=1, "end"=1))
  
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
      
      if(currentSum >0 & maxSum >= currentSum)
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

benchmark <- function(n)
{
  v <- sample(-n:n)
  time <- microbenchmark(naive_cpp(v), naive_r(v), kadane_cpp(v), kadane_r(v), kadane2_cpp(v), kadane2_r(v), max_partial_sum_r(v))
  return (time)
}

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
  

