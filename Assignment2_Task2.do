*use "E:\UNR\Fall Semester 2019-2020\Applied Microeconometrics\Assignment 2\usbal89.dta" 

cd "/home/appertjt/Documents/GradSchool/econometricsFall19/homework2/repo/econometrics743HW2"

clear

use usbal89

tsset id year , yearly
*Column 1*
regress y n n_1 k k_1 y_1 , robust cluster(id)
*Column 2*
xtreg y n n_1 k k_1 y_1 , fe robust cluster(id)
ssc install xtabond2
*Column 3*
xtabond2 y n n_1 k k_1 y_1, gmm(y n k, lag(2 .)) iv(i.year) robust noleveleq
*Column 4*
xtabond2 y n n_1 k k_1 y_1, gmm(y n k, lag(3 .)) iv(i.year) robust noleveleq
*Column 5*
xtabond2 y n n_1 k k_1 y_1, gmm(y n k, lag(2 .)) iv(i.year, equation(level)) robust h(1)
*Column 6*
xtabond2 y n n_1 k k_1 y_1, gmm(y n k, lag(3 .)) iv(i.year, equation(level)) robust h(1)
*An attempt at the comfactor test using testnl*
ereturn list
matrix list e(b)
matrix define beta=e(b)
scalar pi_one=beta[1,1]
di pi_one
scalar pi_two=beta[1,2]
di pi_two
scalar pi_three=beta[1,3]
scalar pi_four=beta[1,4]
scalar pi_five=beta[1,5]
testnl pi_two=-(pi_one*pi_five)
gen cf1=pi_one*pi_five
gen cf2=pi_three*pi_five
testnl pi_two=-cf1
testnl pi_four=-cf2




