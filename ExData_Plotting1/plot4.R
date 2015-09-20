## CREATION OF PLOT 4 FROM COURESERA'S Exploratory Data Analysis Course Project 1

## reading a whole dataset of "household power comsumption" from web url
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    data_hpc_raw <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";")
    unlink(temp)
    if (dispDatasetsInRStudio){
        View(data_hpc_raw) #displaying dataset in Rstudio   
    }

## creating a variable from the dates 2007-02-01 and 2007-02-02
    Global_active_power<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",3]
    Global_active_power<-as.numeric(as.character(Global_active_power))
    
    Voltage<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",5]
    Voltage<-as.numeric(as.character(Voltage))
    
    Energy_sub_metering_1<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",7]
    Energy_sub_metering_1<-as.numeric(as.character(Energy_sub_metering_1))
    Energy_sub_metering_2<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",8]
    Energy_sub_metering_2<-as.numeric(as.character(Energy_sub_metering_2))
    Energy_sub_metering_3<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",9]
    Energy_sub_metering_3<-as.numeric(as.character(Energy_sub_metering_3))
    Date_time <-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",c(1,2)]
    Date_time <- strptime(paste(Date_time$Date,Date_time$Time), 
                          format="%d/%m/%Y %H:%M:%S") 

    Global_reactive_power<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",4]
    Global_reactive_power<-as.numeric(as.character(Global_reactive_power))

## creating a plot
    par(mfrow=c(2,2))
    
    #plot 1
    plot(Global_active_power,
         ylab="Global Active Power",
         xlab="",
         type="l",
         col=rgb(0,0,0),
         xaxt="n")
    axis(1, at=c(1,length(Global_active_power)/2,length(Global_active_power)),labels=c("Thu","Fri","Sat"))

    #plot 2
    plot(Voltage,
         ylab="Voltage",
         xlab="datetime",
         type="l",
         col=rgb(0,0,0),
         xaxt="n")
    axis(1, at=c(1,length(Voltage)/2,length(Voltage)),labels=c("Thu","Fri","Sat"))

    #plot 3
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
    legend(x=length(Energy_sub_metering_1)*3/7-200,
           y=39.5,
           legend=names(data_hpc_raw)[7:9], 
           col=c(rgb(0,0,0),"red","blue"),  
           lty=c(1,1,1),
           bty="n",
           cex=0.75, 
           pt.cex = 1)

    #plot 4
    plot(Global_reactive_power,
         ylab="Global_reactive_power",
         xlab="datetime",
         type="l",
         col=rgb(0,0,0),
         xaxt="n")
    axis(1, at=c(1,length(Global_active_power)/2,length(Global_active_power)),labels=c("Thu","Fri","Sat"))

## saving a plot
    dev.copy(png,file="plot4.png", width=480, height=480)
    dev.off()