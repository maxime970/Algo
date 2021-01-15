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
      if (runningSum >= max)
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
  NumericVector res = {globalMax, start, end};
  return res;
}

// [[Rcpp::export]]
NumericVector group_positive_cpp(NumericVector v)
{
  int n = v.length();
  NumericVector res = {v[0]};
  
  for (int i=0; i<n-1; i++)
  {
    if (v[i]>=0 && v[i+1]>=0)
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






