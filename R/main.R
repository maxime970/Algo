library(microbenchmark)
library(Rcpp)

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
      if (runningSum > max){
        max <- runningSum
        start <- i
        end <- j
      }
    }
  }
  return (c(max, start, end))
}

kadane_r <- function(v) 
{
  # KADANE's algorithm
  # complexity: O(n)
  # on parcourt une seule fois la liste
  # on actualise le max et les bornes au fur et à mesure du parcours
  n = length(v)
  start = 0
  end = 0
  globalMax = -Inf
  max = -Inf
  for (i in 1:n) 
  {
    if (v[i] > max + v[i]) 
    {
      start = i
      max = v[i]
    } 
    else
    {
      max = max + v[i]
    }
    if (globalMax <= max) 
    {
      globalMax = max
      end = i
    }
  }
  return (c(globalMax, start, end))
}

max_partial_sum_r <- function(A){
  
  currentSum = 0 # a pointer that will look over the array and evaluate the accumulated sum at each iteration
  
  maxSum = 0 # a variable that will help us to store the max of currentSum at each step
  
  I = c(0); J = c(0); C =c() # a way to keep truck on the start and the end indices of the subarray we are looking for
  # we initialize I and J with 0 to avoid -Inf returned by the max  if one of them is empty 
  
  if(length(A) == 1 & is.na(A[1]) == TRUE)
    stop("Not callable for an empty array") # we raise an exception
  
  if(length(A) == 1) 
    return(list(MaxSum=maxSum,indx_start = indx_start, indx_end =indx_end))
  
  else {
    
    for(i in 1:length(A)) {
      
      currentSum = currentSum + A[i]
      
      if(currentSum <= 0) {
        currentSum = 0
        J = c(J, i)}
      
      if(currentSum >0 & maxSum >= currentSum)
        C = c(C, i)
      
      if(maxSum < currentSum) {
        maxSum = currentSum
        I = c(I, i)
      }
      
    }
    
    
    indx_end = max(I)
    indx_start = min(min(C[C>max(J[J<indx_end])]), min(I[I>max(J[J<indx_end])]))
    
    
    return(list(MaxSum=maxSum, indx_start = indx_start, indx_end = indx_end))
  }
}

benchmark <- function(n)
{
  v <- sample(-n:n)
  nr <- naive_r(v)
  nc <- naive_cpp(v)
  kr <- kadane_r(v)
  kc <- kadane_cpp(v)
  mpsr <- max_partial_sum_r(v)
  time <- microbenchmark(kadane_cpp(v), kadane_r(v), naive_cpp(v), naive_r(v), max_partial_sum_r(v))
  return (time)
}


