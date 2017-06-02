## Put comments here that give an overall description of what your
## functions do

## creates a special "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
	cm <- NULL
	set <- function(y) {
		x <<- y
		cm <<- NULL
	}
	
	get <- function() x
	setinvmat <- function(invmat) cm <<- invmat
	getinvmat <- function() cm
	list(set = set, get = get,
			setinvmat = setinvmat,
			getinvmat = getinvmat)
}


## Retrieve the inverse from the cache,
## if the inverse has already been calculated.

cacheSolve <- function(x, ...) {
	## Return a matrix that is the inverse of 'x'
	cm <- x$getinvmat()
	if(!is.null(cm)) {
		message("getting cached data")
		return(cm)
	}
	data <- x$get()
	cm <- solve(data, ...)
	x$setinvmat(cm)
	cm
}


# Testing the functions
orimat <- matrix(rnorm(9), 3, 3)
x <- makeCacheMatrix()
set.seed(1)
x$set(orimat)

cacheSolve(x)
cacheSolve(x) #getting cached data

