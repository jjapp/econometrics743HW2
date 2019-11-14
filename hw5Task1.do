cd "/home/appertjt/Documents/GradSchool/econometricsFall19/homework2/repo/econometrics743HW2"

clear

use invrat1

*summarize the data
summarize

*tab firm

*Ordinary least squares
*Start with creating a lagged variable for investment rate
*Need to sort by firm and by year
sort firm year
by firm: gen invrate_lag = invrate[_n-1]

reg invrate invrate_lag i.year

*Do the within groups regression
*Note: this is currently returning a higher value than paper
*FF says to expect this difference in assignment.

xtreg invrate invrate_lag i.year, fe


