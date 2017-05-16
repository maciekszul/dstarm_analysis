# set working directory to source file location!!!
library(DstarM)
library(sm)

# data load
kb <- read.csv('RTforR_keyboard.csv') # data from keyboard
joy <- read.csv('RTforR_joystick.csv') # data from joystick

colnames(kb) <- c('pp', 'condition', 'response', 'rt')
colnames(joy) <- c('pp', 'condition', 'response', 'rt')
kb$response <- kb$response == 'True'
joy$response <- joy$response == 'True'

kb$pp <- as.factor(kb$pp)
kb$condition <- as.factor(kb$condition)
kb$rt <- as.numeric(kb$rt)

joy$pp <- as.factor(joy$pp)
joy$condition <- as.factor(joy$condition)
joy$rt <- as.numeric(joy$rt)

tt <- seq(0, 4, 0.001)

# default settings
default = byParticipant(data = joy, argsEstDstarM = list(tt == tt))
