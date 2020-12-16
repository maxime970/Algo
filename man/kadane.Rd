\name{kadane}
\alias{kadane}
\title{
Function that finds the subarray whithin an array that has the largest sum
}
\description{
It takes an array as input and it spills out three values: the value of sum, the start and the end indexes in the original array}
\usage{
kadane_solution(v)
}
\arguments{
  \item{v}{an array of length  n>0}
}
\details{
The time complexity of this function is linear}
\value{
\item{globalMax}{the sum of subarray found by the function}
\item{start}{the starting index of the subarray in the original array}
\item{end}{the ending index of the subarray in the original array}
}
\examples{
kadane_solution(c(0, -5, 7, -5, 15, 10, -8, 9, -5))

}
\keyword{v}
