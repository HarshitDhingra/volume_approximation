#' Generator function for cross polytopes
#' 
#' This function can be used to generate the \eqn{d}-dimensional cross polytope in H- or V-representation.
#' 
#' @param dimension The dimension of the cross polytope.
#' @param rep A string to declare the representation. It has to be \code{'H'} for H-representation or \code{'V'} for V-representation.
#' 
#' @return A polytope class representing a cross polytope in H- or V-representation.
#' @examples 
#' # generate a 10-dimensional cross polytope in H-representation
#' P = gen_cross(10, 'H')
#' 
#' # generate a 15-dimension cross polytope in V-representation
#' P = gen_cross(15, 'V')
#' @export
gen_cross <- function(dimension, rep) {
  
  kind_gen = 2
  m_gen = 0
  if (rep == "V") {
    Vpoly_gen = TRUE
  } else if (rep == "H") {
    Vpoly_gen = FALSE
  } else {
    stop('Not a known representation.')
  }
  
  Mat = poly_gen(kind_gen, Vpoly_gen, FALSE, dimension, m_gen)
  
  # first column is the vector b
  b = Mat[,1]
  Mat = Mat[,-c(1)]
  
  if (Vpoly_gen) {
    P = Vpolytope$new(Mat, 2^dimension / prod(1:dimension))
  } else {
    P = Hpolytope$new(-Mat, b, 2^dimension / prod(1:dimension))
  }
  
  return(P)
}