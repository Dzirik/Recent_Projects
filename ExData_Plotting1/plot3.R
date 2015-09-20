## CREATION OF PLOT 3 FROM COURESERA'S Exploratory Data Analysis Course Project 1

dispDatasetsInRStudio<-"False" #variable indicating displaying datasets in RStudio

## reading a whole dataset of "household power comsumption" from web url
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    data_hpc_raw <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";")
    unlink(temp)
    if (dispDatasetsInRStudio){
        View(data_hpc_raw) #displaying dataset in Rstudio   
    }

## creating a variable from the dates 2007-02-01 and 2007-02-02
    Energy_sub_metering_1<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",7]
    Energy_sub_metering_1<-as.numeric(as.character(Energy_sub_metering_1))
    Energy_sub_metering_2<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",8]
    Energy_sub_metering_2<-as.numeric(as.character(Energy_sub_metering_2))
    Energy_sub_metering_3<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",9]
    Energy_sub_metering_3<-as.numeric(as.character(Energy_sub_metering_3))
    Date_time <-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",c(1,2)]
    Date_time <- strptime(paste(Date_time$Date,Date_time$Time), 
                          format="%d/%m/%Y %H:%M:%S") 
    if (dispDatasetsInRStudio){
        View(Energy_sub_metering_1) #displaying dataset in Rstudio 
        View(Energy_sub_metering_2) #displaying dataset in Rstudio
        View(Energy_sub_metering_3) #displaying dataset in Rstudio
        View(Date_time) #displaying dataset in Rstudio
    }

## creating a plot
    #plot(Date_time,
    #     Energy_sub_metering,
    #     ylab="Global Active Power (kilowatts)",
    #     xlab="",
    #     type="l",
    #     col=rgb(0,0,0),
    #     xaxt="n")
    
    #unfortunalely x-axis labels are not in English but in Czech, so I forced the English titles as follows

    plot(Energy_sub_metering_1,
         ylab="Energy sub metering",
         xlab="",
         type="l",
         col=rgb(0,0,0),
         xaxt="n")
    lines(Energy_sub_metering_2,
         type="l",
         col="red")
    lines(Energy_sub_metering_3,
          type="l",
          col="blue")
    axis(1, at=c(1,length(Energy_sub_metering_1)/2,length(Energy_sub_metering_1)),labels=c("Thu","Fri","Sat"))
    legend("topright",
           legend=names(data_hpc_raw)[7:9], 
           col=c(rgb(0,0,0),"red","blue"),  
           lty=c(1,1,1),
           cex=1, pt.cex = 2)

#   legend(x=length(Energy_sub_metering_1)*2/3,
#           y=39.5,
#           legend=names(data_hpc_raw)[7:9], 
#           col=c(rgb(0,0,0),"red","blue"),  
#           lty=c(1,1,1),
#           cex=1, 
#           pt.cex = 2)

## saving a plot
    #IT WAS IMPOSSIBLE TO REACH THE LEGEND IN RESOLUTION 480X480
    dev.copy(png,file="plot3.png", width=750, height=750)
    dev.off()