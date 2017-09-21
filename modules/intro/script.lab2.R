dd=scan("100men",sep="\t",what="")
data.men=matrix(dd,ncol=3,byrow=T)

dd2=scan("100women",sep="\t",what="")
data.women=matrix(dd2,ncol=6,byrow=T)

time.men=as.numeric(data.men[-1,2])
temp=data.men[-1,3]
year.men=as.numeric(substring(temp,nchar(temp)-3,nchar(temp)) )



time.women=as.numeric(data.women[-1,1])

temp=data.women[-1,6]
year.women=as.numeric(substring(temp,nchar(temp)-3,nchar(temp)) )

year.men=rev(year.men)
time.men=rev(time.men)

par(mfrow=c(1,2))

plot(year.men,time.men,type="b")

plot(year.women,time.women,type="b")

prop.dec.men=diff(time.men)/time.men[-1]
plot(year.men[-length(year.men)],prop.dec.men, xlab="year",ylab="Proportional decrease")

title("Men")
prop.dec.women=diff(time.women)/time.women[-1]
plot(year.women[-length(year.women)],prop.dec.women, xlab="year",ylab="Proportional decrease")
title("Women")


plot(year.men[-length(year.men)],prop.dec.men, xlab="year",ylab="Proportional decrease",ylim=range(prop.dec.women))

title("Men")













