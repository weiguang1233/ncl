C
C $Id: curvss.f,v 1.3 2000-08-22 15:19:35 haley Exp $
C                                                                      
C                Copyright (C)  2000
C        University Corporation for Atmospheric Research
C                All Rights Reserved
C
C This file is free software; you can redistribute it and/or modify
C it under the terms of the GNU General Public License as published
C by the Free Software Foundation; either version 2 of the License, or
C (at your option) any later version.
C
C This software is distributed in the hope that it will be useful, but
C WITHOUT ANY WARRANTY; without even the implied warranty of
C MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
C General Public License for more details.
C
C You should have received a copy of the GNU General Public License
C along with this software; if not, write to the Free Software
C Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
C USA.
C
      subroutine curvss (n,x,y,d,isw,s,eps,ys,ysp,sigma,td,
     *                   tsd1,hd,hsd1,hsd2,rd,rsd1,rsd2,v,
     *                   ierr)
c
      integer n,isw,ierr
      real x(n),y(n),d(n),s,eps,ys(n),ysp(n),sigma,td(n),
     *     tsd1(n),hd(n),hsd1(n),hsd2(n),rd(n),rsd1(n),
     *     rsd2(n),v(n)
c
c                                 coded by alan kaylor cline
c                           from fitpack -- january 26, 1987
c                        a curve and surface fitting package
c                      a product of pleasant valley software
c                  8603 altus cove, austin, texas 78759, usa
c
c this subroutine determines the parameters necessary to
c compute a smoothing spline under tension. for a given
c increasing sequence of abscissae (x(i)), i = 1,..., n and
c associated ordinates (y(i)), i = 1,..., n, the function
c determined minimizes the summation from i = 1 to n-1 of
c the square of the second derivative of f plus sigma
c squared times the difference of the first derivative of f
c and (f(x(i+1))-f(x(i)))/(x(i+1)-x(i)) squared, over all
c functions f with two continuous derivatives such that the
c summation of the square of (f(x(i))-y(i))/d(i) is less
c than or equal to a given constant s, where (d(i)), i = 1,
c ..., n are a given set of observation weights. the
c function determined is a spline under tension with third
c derivative discontinuities at (x(i)), i = 2,..., n-1. for
c actual computation of points on the curve it is necessary
c to call the function curv2.
c
c on input--
c
c   n is the number of values to be smoothed (n.ge.2).
c
c   x is an array of the n increasing abscissae of the
c   values to be smoothed.
c
c   y is an array of the n ordinates of the values to be
c   smoothed, (i. e. y(k) is the functional value
c   corresponding to x(k) ).
c
c   d is a parameter containing the observation weights.
c   this may either be an array of length n or a scalar
c   (interpreted as a constant). the value of d
c   corresponding to the observation (x(k),y(k)) should
c   be an approximation to the standard deviation of error.
c
c   isw contains a switch indicating whether the parameter
c   d is to be considered a vector or a scalar,
c          = 0 if d is an array of length n,
c          = 1 if d is a scalar.
c
c   s contains the value controlling the smoothing. this
c   must be non-negative. for s equal to zero, the
c   subroutine does interpolation, larger values lead to
c   smoother funtions. if parameter d contains standard
c   deviation estimates, a reasonable value for s is
c   float(n).
c
c   eps contains a tolerance on the relative precision to
c   which s is to be interpreted. this must be greater than
c   or equal to zero and less than equal or equal to one. a
c   reasonable value for eps is sqrt(2./float(n)).
c
c   ys is an array of length at least n.
c
c   ysp is an array of length at least n.
c
c   sigma contains the tension factor. this value indicates
c   the degree to which the first derivative part of the
c   smoothing functional is emphasized. if sigma is nearly
c   zero (e. g. .001) the resulting curve is approximately a
c   cubic spline. if sigma is large (e. g. 50.) the
c   resulting curve is nearly a polygonal line. if sigma
c   equals zero a cubic spline results. a standard value for
c   sigma is approximately 1.
c
c and
c
c   td, tsd1, hd, hsd1, hsd2, rd, rsd1, rsd2, and v are
c   arrays of length at least n which are used for scratch
c   storage.
c
c on output--
c
c   ys contains the smoothed ordinate values.
c
c   ysp contains the values of the second derivative of the
c   smoothed curve at the given nodes.
c
c   ierr contains an error flag,
c        = 0 for normal return,
c        = 1 if n is less than 2,
c        = 2 if s is negative,
c        = 3 if eps is negative or greater than one,
c        = 4 if x-values are not strictly increasing,
c        = 5 if a d-value is non-positive.
c
c and
c
c   n, x, y, d, isw, s, eps, and sigma are unaltered.
c
c this subroutine references package modules terms and
c snhcsh.
c
c-----------------------------------------------------------
c
      if (n .lt. 2) go to 16
      if (s .lt. 0.) go to 17
      if (eps .lt. 0. .or. eps .gt. 1.) go to 18
      ierr = 0
      p = 0.
      v(1) = 0.
      v(n) = 0.
      ysp(1) = 0.
      ysp(n) = 0.
      if (n .eq. 2) go to 14
      rsd1(1) = 0.
      rd(1) = 0.
      rsd2(n) = 0.
      rdim1 = 0.
      yspim2 = 0.
c
c denormalize tension factor
c
      sigmap = abs(sigma)*float(n-1)/(x(n)-x(1))
c
c form t matrix and second differences of y into ys
c
      nm1 = n-1
      nm3 = n-3
      delxi1 = 1.
      delyi1 = 0.
      dim1 = 0.
      do 1 i = 1,nm1
        delxi = x(i+1)-x(i)
        if (delxi .le. 0.) go to 19
        delyi = (y(i+1)-y(i))/delxi
        ys(i) = delyi-delyi1
        call terms (di,tsd1(i+1),sigmap,delxi)
        td(i) = di+dim1
        hd(i) = -(1./delxi+1./delxi1)
        hsd1(i+1) = 1./delxi
        delxi1 = delxi
        delyi1 = delyi
    1   dim1 = di
c
c calculate lower and upper tolerances
c
      sl = s*(1.-eps)
      su = s*(1.+eps)
      if (isw .eq. 1) go to 3
c
c form h matrix - d array
c
      if (d(1) .le. 0. .or. d(2) .le. 0.) go to 20
      betapp = 0.
      betap = 0.
      alphap = 0.
      do 2 i = 2,nm1
        alpha = hd(i)*d(i)*d(i)
        if (d(i+1) .le. 0.) go to 20
        beta = hsd1(i+1)*d(i+1)*d(i+1)
        hd(i) = (hsd1(i)*d(i-1))**2+alpha*hd(i)
     *                             +beta*hsd1(i+1)
        hsd2(i) = hsd1(i)*betapp
        hsd1(i) = hsd1(i)*(alpha+alphap)
        alphap = alpha
        betapp = betap
    2   betap = beta
      go to 5
c
c form h matrix - d constant
c
    3 if (d(1) .le. 0.) go to 20
      sl = d(1)*d(1)*sl
      su = d(1)*d(1)*su
      hsd1p = 0.
      hdim1 = 0.
      do 4 i = 2,nm1
        hdi = hd(i)
        hd(i) = hsd1(i)*hsd1(i)+hdi*hdi+hsd1(i+1)*hsd1(i+1)
        hsd2(i) = hsd1(i)*hsd1p
        hsd1p = hsd1(i)
        hsd1(i) = hsd1p*(hdi+hdim1)
    4   hdim1 = hdi
c
c top of iteration
c cholesky factorization of p*t+h into r
c
    5 do 6 i = 2,nm1
        rsd2i = hsd2(i)
        rsd1i = p*tsd1(i)+hsd1(i)-rsd2i*rsd1(i-1)
        rsd2(i) = rsd2i*rdim1
        rdim1 = rd(i-1)
        rsd1(i) = rsd1i*rdim1
        rd(i) = 1./(p*td(i)+hd(i)-rsd1i*rsd1(i)
     *                           -rsd2i*rsd2(i))
        ysp(i) = ys(i)-rsd1(i)*ysp(i-1)-rsd2(i)*yspim2
    6   yspim2 = ysp(i-1)
c
c back solve of r(transpose)* r * ysp = ys
c
      ysp(nm1) = rd(nm1)*ysp(nm1)
      if (n .eq. 3) go to 8
      do 7 ibak = 1,nm3
        i = nm1-ibak
    7   ysp(i) = rd(i)*ysp(i)-rsd1(i+1)*ysp(i+1)
     *                       -rsd2(i+2)*ysp(i+2)
    8 sum = 0.
      delyi1 = 0.
      if (isw .eq. 1) go to 10
c
c calculation of residual norm
c  - d array
c
      do 9 i = 1,nm1
        delyi = (ysp(i+1)-ysp(i))/(x(i+1)-x(i))
        v(i) = (delyi-delyi1)*d(i)*d(i)
        sum = sum+v(i)*(delyi-delyi1)
    9   delyi1 = delyi
      v(n) = -delyi1*d(n)*d(n)
      go to 12
c
c calculation of residual norm
c  - d constant
c
   10 do 11 i = 1,nm1
        delyi = (ysp(i+1)-ysp(i))/(x(i+1)-x(i))
        v(i) = delyi-delyi1
        sum = sum+v(i)*(delyi-delyi1)
   11   delyi1 = delyi
      v(n) = -delyi1
   12 sum = sum-v(n)*delyi1
c
c test for convergence
c
      if (sum .le. su) go to 14
c
c calculation of newton correction
c
      f = 0.
      g = 0.
      wim2 = 0.
      wim1 = 0.
      do 13 i = 2,nm1
        tui = tsd1(i)*ysp(i-1)+td(i)*ysp(i)
     *                        +tsd1(i+1)*ysp(i+1)
        wi = tui-rsd1(i)*wim1-rsd2(i)*wim2
        f = f+tui*ysp(i)
        g = g+wi*wi*rd(i)
        wim2 = wim1
   13   wim1 = wi
      h = f-p*g
      if (h .le. 0.) go to 14
c
c update p - newton step
c
      step = (sum-sqrt(sum*sl))/h
      if (sl .ne. 0.) step = step*sqrt(sum/sl)
      p = p+step
      go to 5
c
c store smoothed y-values and second derivatives
c
   14 do 15 i = 1,n
        ys(i) = y(i)-v(i)
   15   ysp(i) = p*ysp(i)
      return
c
c n less than 2
c
   16 ierr = 1
      return
c
c s negative
c
   17 ierr = 2
      return
c
c eps negative or greater than 1
c
   18 ierr = 3
      return
c
c x-values not strictly increasing
c
   19 ierr = 4
      return
c
c weight non-positive
c
   20 ierr = 5
      return
      end
