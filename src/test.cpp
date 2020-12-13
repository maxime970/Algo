#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector naive_cpp(NumericVector v)
{
  int n = v.length();
  int start = 0;
  int end = 0;
  double max = -INFINITY;
  for (int i=0; i<n; i++)
  {
    double runningSum = 0;
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
  double globalMax = -INFINITY;
  double max = -INFINITY;
  
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

/*
// [[Rcpp::export]]
double Midpoint_Crosssum(NumericVector v, int low, int mid, int high) 
{ 
  int sum = 0; 
  double leftsum = -INFINITY; 
  for (int i=mid; i >= low; i--) 
  { 
    sum += v[i]; 
    if (sum >= leftsum) 
      leftsum = sum; 
  } 
  sum = 0; 
  int rightsum = -INFINITY; 
  for (int i=mid+1; i <= high; i++) 
  { 
    sum += v[i]; 
    if (sum > rightsum) 
      rightsum = sum; 
  } 
  return leftsum + rightsum; 
} 

// [[Rcpp::export]]
NumericVector Left_Right_MaximumSubarray(NumericVector v, int low, int high) 
{  
  if (low == high) 
    return v[low];  
  else 
  {
    int mid = (low + high)/2; 
    return std::max<double>(std::max<double>(Left_Right_MaximumSubarray(v, low, mid), Left_Right_MaximumSubarray(v, mid+1, high)), Midpoint_Crosssum(v, low, mid, high));
  }   
}
*/

