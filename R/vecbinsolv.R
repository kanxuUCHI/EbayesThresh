"vecbinsolv" <-
function(zf, fun, tlo, thi, nits = 30, ...)
{
#  given a monotone function fun, and a vector of values
#  zf find a vector of numbers t such that f(t) = zf.
#  The solution is constrained to lie on the interval (tlo, thi)
#
#  The function fun may be a vector of increasing functions 
#
#  Present version is inefficient because separate calculations
#  are done for each element of z, and because bisections are done even
#  if the solution is outside the range supplied
#    
#  It is important that fun should work for vector arguments.
#   Additional arguments to fun can be passed through ...
#
#  Works by successive bisection, carrying out nits harmonic bisections
#   of the  interval between tlo and thi
#
	nz <- length(zf)
	if(length(tlo)==1) tlo <- rep(tlo, nz)
	if(length(tlo)!=nz) stop("Lower constraint has to be homogeneous or has the same length as #functions.")
	if(length(thi)==1) thi <- rep(thi, nz)
	if(length(thi)!=nz) stop("Upper constraint has to be homogeneous or has the same length as #functions.")

#  carry out nits bisections
#
	for(jj in (1:nits)) {
		tmid <- (tlo + thi)/2
		fmid <- fun(tmid, ...)
		indt <- (fmid <= zf)
		tlo[indt] <- tmid[indt]
		thi[!indt] <- tmid[!indt]
	}
	tsol <- (tlo + thi)/2
	return(tsol)
}
