##19.06.2014
##functions for caching matrix and its inversion

## function "makeCacheMatrix" creates an object for storing matrix and its inversion
## usage and test of function "makeCacheMatrix"
##   M<-makeCacheMatrix()             #creating an object
##   M$set(matrix(1:4,nrow=2,ncol=2)) #iserting a matrix into it
##   M$get()                          #obtaining a value of the matrix
##   M$setinverse(solve(M$get()))     #computing an iverse
##   M$getinverse()                   #obtaining a value of the inverse
##   M$getinverse()%*%M$get()         #testing if it is an inverse

makeCacheMatrix <- function(A = matrix()) {
    inverse <- NULL
    set <- function(B) {
        A <<- B
        inverse <<- NULL
    }
    get <- function() A
    setinverse <- function(inv) inverse <<- inv
    getinverse <- function() inverse
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}

## function "cacheSolve" return a matrix that is the inverse of matrix A
## in first run it creates inverse, in next runes it gets it from cache
## A is object created by function "makeCacheMatrix"
## usage and test of function "cacheSolve"
##   M<-makeCacheMatrix()             #creating an object
##   M$set(matrix(1:4,nrow=2,ncol=2)) #iserting a matrix into it
##   M$get()                          #obtaining a value of the matrix
##   cacheSolve(M)                    #work with inverse
##   M$get()%*%M$getinverse()         #testing if it is an inverse

cacheSolve <- function(A, ...) {
    inverse <- A$getinverse()
    if(is.null(inverse)) {
        inverse<-solve(A$get(),...)
        A$setinverse(inverse)
        message("creating inverse")
    }else{
        message("getting cached data")
    }
    inverse
}
