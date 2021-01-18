#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector naive_cpp(NumericVector v)
{
  int n = v.length();
  int start = 0;
  int end = 0;
  int max = INT_MIN;
  for (int i=0; i<n; i++)
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
  int n = v.length();
  int globalMax = INT_MIN;
  int localMax = 0;
  int start = 0;
  int end = 0;
  int s = 0; 
  
  for (int i=0; i<n; i++) 
  { 
    localMax += v[i]; 
    if (localMax > globalMax) 
    { 
      globalMax = localMax; 
      start = s; 
      end = i; 
    } 
    if (localMax < 0) 
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
  int n = v.length();
  NumericVector res;
  res.push_back(v[0]);
  
  for (int i=0; i<n-1; i++)
  {
    if (v[i] >= 0 && v[i+1] >= 0)
    {
      int new_length = res.length();
      res[new_length-1] = res[new_length-1] + v[i+1];
    }
    else
    {
      res.push_back(v[i+1]);
    }
  }
  return res;
}

// [[Rcpp::export]]
NumericVector kadane2_cpp(NumericVector v)
{
  NumericVector v_grp = group_positive_cpp(v);
  NumericVector res = kadane_cpp(v_grp);
  return res;
}

/*
// [[Rcpp::export]]
NumericVector max_partial_sum_cpp(NumericVector v)
{
  int currentSum = 0;
  int maxSum = 0;
  NumericVector I = {0};
  NumericVector J = {0};
  NumericVector C;
  n = v.length();
  if (n == 1)
  {
    NumericVector res = NumericVector::create(_["max"]=v[1], _["start"]=0, _["end"]=0);
    return res;
  }
  else{
    for (int i=0; i<n; i++){
      currentSum += v[i];
      if (currentSum <= 0)
      {
        currentSum = 0;
        J.push_back(i);
      }
      if (currentSum > 0 && maxSum >= currentSum){
        C.push_back(i);
      }
      if (maxSum < currentSum){
        maxSum = currentSum;
        I.push_back(i);
      }
    }
  }
  int end = std::max(I);
  start = std::min(std::min(C[C>std::max(J[J<end])]), std::min(I[I>std::max(J[J<end])]));
  NumericVector res = NumericVector::create(_["max"]=maxSum, _["start"]=start, _["end"]=end);
  return res;
}
*/







