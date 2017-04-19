# set working directory to source file location!!!
library(DstarM)
library(sm)
# data load
kb <- read.csv('RTforR_keyboard.csv') # data from keyboard
joy <- read.csv('RTforR_joystick.csv') # data from joystick

# data clean
colnames(kb) <- c('pp', 'condition', 'response', 'rt')
colnames(joy) <- c('pp', 'condition', 'response', 'rt')
kb$response <- kb$response == 'True'
joy$response <- joy$response == 'True'

# subject data selection
subj <- sort((unique(kb$pp)))[3] 

kb_p <- kb[kb$pp == subj,]
joy_p <- joy[joy$pp == subj,]

# clean
kb_p$pp <- as.factor(kb_p$pp)
kb_p$condition <- as.factor(kb_p$condition)
kb_p$pp <- as.factor(kb_p$pp)
kb_p$condition <- as.factor(kb_p$condition)

joy_p$pp <- as.factor(joy_p$pp)
joy_p$condition <- as.factor(joy_p$condition)
joy_p$pp <- as.factor(joy_p$pp)
joy_p$condition <- as.factor(joy_p$condition)

# plots
kb_cor <- kb_p[kb_p$response == TRUE,]
sm.density.compare(kb_cor$rt, group = (kb_cor$condition)) # condition
legend("topright", levels(kb_p$condition), fill=2+(0:nlevels(kb_p$condition)))

joy_cor <- joy_p [joy_p$response == TRUE,]
sm.density.compare(joy_cor$rt, group = (joy_cor$condition)) # condition
legend("topright", levels(joy_p$condition), fill=2+(0:nlevels(joy_p$condition)))

# DstarM

## default
tt <- seq(0, 4, 0.01)

joy_est <- estDstarM(data = joy_p, tt = tt, verbose = FALSE)
coef(joy_est)
summary(joy_est)

kb_est <- estDstarM(data = kb_p, tt = tt, verbose = FALSE)
coef(kb_est)
summary(kb_est)

save.image("single_subject_dstarm.RData")

## bounded + fixed

lower <- c(0.01, -6.00, 0.05, 0.00, 0.00)
upper <- c(6.00, 6.00, 0.95, 0.99, 10.00)

restr = matrix(1:10, 5, 2)
restr[c(1,6)] = c(1,1)
restr[c(3,8)] = c(3,3)

joy_est_bf <- estDstarM(data = joy_p, tt = tt, lower = lower, upper = upper, restr = restr, verbose = FALSE)
coef(joy_est_bf)
summary(joy_est_bf)

kb_est_bf <- estDstarM(data = kb_p, tt = tt, lower = lower, upper = upper, restr = restr, verbose = FALSE)
coef(kb_est_bf)
summary(kb_est_bf)

save.image("single_subject_dstarm.RData")
