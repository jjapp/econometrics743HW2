use "E:\UNR\Fall Semester 2019-2020\Applied Microeconometrics\Assignment 2\usbal89.dta" 
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
