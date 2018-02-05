## makeCacheMatrix and cacheSolve are a pair of function which evaluate inverse of
## a matrix and cache it through list object. When we try to get inverse of matrix for the same matrix value then
## it will be get it from cache rather than computing once again.

## makeCacheMatrix function have list object, which helps to set/get matrix/inverse of matrix value in it.
## Also when we alter matrix value of the list object inverse of matrix value will be re-set as NULL.

makeCacheMatrix <- function(x = matrix()) {
		m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setinverse <- function(solve) m <<- solve
        getinverse <- function() m
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## cacheSolve function attempts to fetch inverse of matrix value from cache if it is already computed and stored.
## otherwise this function will compute inverse of matrix for argument passed and will be stored in list object for feature reference,
## and return inverse of matrix value as result.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
		
		m <- x$getinverse()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- solve(data, ...)
        x$setinverse(m)
        m
}
