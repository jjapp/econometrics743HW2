cd "/home/appertjt/Documents/GradSchool/econometricsFall19/homework2/repo/econometrics743HW2"

clear

use invrat1

*summarize the data
summarize

log using /home/appertjt/Documents/GradSchool/econometricsFall19/homework2/repo/econometrics743HW2/inv.log, replace

*Ordinary least squares
*Start with creating a lagged variable for investment rate
*Need to sort by firm and by year
sort firm year
by firm: gen invrate_lag = invrate[_n-1]

reg invrate invrate_lag i.year, robust

*Now do the same regression using the instructions from Fossen's do file

tsset firm year, yearly

xi: regress invrate l.invrate i.year, robust cluster(firm)

*Both methods return the same results for coefficients but slightly different standard errors


*Do the within groups regression
*Note: this is currently returning a higher value than paper
*FF says to expect this difference in assignment.

xtreg invrate invrate_lag i.year, fe

*2SLS estimate using the second lagged variable and first differences

sort firm year
by firm: gen invrate_lag2 = invrate_lag[_n-1]
by firm: gen invrate_lag3=invrate_lag2[_n-1]

ivregress 2sls d.invrate i.year (d.invrate_lag=invrate_lag2), robust cluster(firm)

*gmm estimator

xi: xtabond invrate i.year , maxldep(2) robust

*test for serial correlation
estat abond


*Now run it again without restrictions on the levels

xi: xtabond invrate i.year , robust

*test for serial correlation
estat abond

clear
use usbal89
tsset id year , yearly
*Column 1*
regress y n n_1 k k_1 y_1 i.year , robust cluster(id)
*Column 2*
xtreg y n n_1 k k_1 y_1 i.year , fe robust cluster(id)
ssc install xtabond2
*Column 3*
xtabond2 y n n_1 k k_1 y_1 i.year, gmm(y n k, lag(2 .)) iv(i.year) robust noleveleq
*Column 4*
xtabond2 y n n_1 k k_1 y_1 i.year, gmm(y n k, lag(3 .)) iv(i.year) robust noleveleq
*Column 5*
xtabond2 y n n_1 k k_1 y_1 i.year, gmm(y n k, lag(2 .)) iv(i.year, equation(level)) robust h(1)
*Column 6*
xtabond2 y n n_1 k k_1 y_1 i.year, gmm(y n k, lag(3 .)) iv(i.year, equation(level)) robust h(1)
* test using testnl*
testnl _b[n_1]= -_b[n]*_b[y_1]
testnl _b[k_1]= -_b[k]*_b[y_1]
log close
