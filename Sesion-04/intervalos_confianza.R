x1 <- rnorm(1000,mean=175, sd = 20)
hist(x1, breaks = 200)
x2 <- rnorm(1000,175,1)
hist(x2, breaks=200)

q025.1 = qnorm(0.025,175,20)
q975.1 <- qnorm(0.975,175,20)

q025.2 <- qnorm(0.025,175,1)
q975.2 <- qnorm(0.975,175,1)
