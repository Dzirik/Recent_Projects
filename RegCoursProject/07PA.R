# DATA READING -----------------------------------------------------------------------------------

    data(mtcars)
    head(mtcars)
    ?mtcars
    
    data<-mtcars[,c(9,1)]
    View(data)

# EDA PLOTTING ------------------------------------------------------------------------------------

    par(mfrow=c(1,2))
    
    #plotting situation 2
        plot(data[data$am==1,],
             type="p",
             pch=0,
             xlab="Miles Per Gallon",
             ylab="Transmission",
             xlim=c(0,1),
             ylim=c(min(data$mpg),max(data$mpg)))
        
        points(data[data$am==0,],pch=8)
        
        legend("topleft",
               legend=c("Automatic","Manual"), 
               pch=c(8,0))
    
    #plotting boxplot
        boxplot(mpg~am,
                data=mtcars,
                xlab="Miles Per Gallon",
                ylab="Transmission",
                xaxt="n")
        axis(1, at=c(1,2),labels=c("Automatic","Manual"))

    par(mfrow=c(1,1))

# REGRESSION ----------------------------------------------------------------------------------------

    tran<-factor(data[,1])
    mpg<-data[,2]
    
    #estimation of parameters
    MWhole<-lm(mpg~tran)
    
    #values of parameters and their significance
    
    #summary(MWhole)
    summ<-summary(MWhole)$coefficients
    row.names(summ)<-c("Automatic","Change Auto-Manual")

    confInt<-confint(MWhole,level=0.90)
    row.names(confInt)<-c("Automatic","Change Auto-Manual")
    
    randsigma<-data.frame(Values=c(summary(MWhole)$r.squared,summary(MWhole)$sigma))
    row.names(randsigma)<-c("R squared","sigma")

    summ
    confint
    randsigma
    
    par(mfrow=c(2,2))
    plot(MWhole)

#------------------------------------
tran<-factor(data[,1])
mpg<-data[,2]
x<-data[data[,1]==1,1]
y<-mpg[data[,1]==1]
MManual<-lm(y~x-1)
summary(MManual)
a<-summary(MManual)$coefficients
mean(y)

#------------------------------------

x<-data[data[,1]==0,1]
y<-mpg[data[,1]==0]
MAutomatic<-lm(y~I(x+1)-1)
summary(MAutomatic)

mean(y)

plot(x,resid(MAutomatic))

# LOGISTICS -------------------------------------------------------------------------------------------

logisticka<-glm(am~mpg,mtcars,family=binomial)
summary(logisticka)

#confidence
(logisticka$coefficients)
(confint(logisticka))