\name{MaxSubArray}
\alias{MaxSubArray}
\title{
Function that finds the subarray which has the largest sum whithin an array
}
\description{
It takes an array as input and it spills out three values: the value of sum, the start and the end indexes in the original array}
\usage{
max_subarray(A)
}
\arguments{
  \item{A}{an array of length > 0}
}
\details{
The time complexity of this function is linear}
\value{
\item{maxSum}{the sum of subarray found by the function}
\item{indx_start}{the starting index of the subarray in the original array}
\item{indx_end}{the ending index of the subarray in the original array}
}
\examples{
max_subarray(c(2, -1, 3, -5, 10, 8, -8, 0))
}
\keyword{A}
