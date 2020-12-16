#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector naive_cpp(NumericVector v)
{
  int n = v.length();
  int start = 0;
  int end = 0;
  int max = -INFINITY;
  for (int i=0; i<n; i++)
  {
    int runningSum = 0;
    for (int j=i; j<n; j++)
    {
      runningSum += v[j];
      if (runningSum > max)
      {
        max = runningSum;
        start = i;
        end = j;
      }
    }
  }
  NumericVector res = {max, start, end};
  return res;
}

// [[Rcpp::export]]
NumericVector kadane_cpp(NumericVector v) 
{
  int n = v.length();
  int start = 0;
  int end = 0;
  int globalMax = -INFINITY;
  int max = -INFINITY;
  
  for (int i=0; i<n; i++) 
  {
    if (v[i] > max + v[i]) 
    {
      start = i;
      max = v[i];
    } 
    else
    {
      max += v[i];
    }
    if (globalMax <= max) 
    {
      globalMax = max;
      end = i;
    }
  }
  NumericVector res = {globalMax, start, end};
  return res;
}






