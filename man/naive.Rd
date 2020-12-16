\name{naive}
\alias{naive}
\title{
Function that finds the subarray which has the largest sum whithin an array
}
\description{
It takes an array as input and it spills out three values: the value of sum, the start and the end indexes in the original array}
\usage{
naive_solver(v)
}
\arguments{
  \item{v}{an array of length  n>0}
}
\details{
The time complexity of this function is quadratic}
\value{
\item{max}{the sum of subarray found by the function}
\item{start}{the starting index of the subarray in the original array}
\item{end}{the ending index of the subarray in the original array}
}
\examples{
naive_solver(c(5, -5, 3, -5, 10, 10, -8, 9, -5))

}
\keyword{v}
