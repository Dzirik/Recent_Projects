## CREATION OF PLOT 2 FROM COURESERA'S Exploratory Data Analysis Course Project 1

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
    Global_active_power<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",3]
    Global_active_power<-as.numeric(as.character(Global_active_power))
    Date_time <-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",c(1,2)]
    Date_time <- strptime(paste(Date_time$Date,Date_time$Time), 
                          format="%d/%m/%Y %H:%M:%S") 
    if (dispDatasetsInRStudio){
        View(Global_active_power) #displaying dataset in Rstudio 
        View(Date_time) #displaying dataset in Rstudio
    }

## creating a plot
    #plot(Date_time,
    #     Global_active_power,
    #     ylab="Global Active Power (kilowatts)",
    #     xlab="",
    #     type="l",
    #     col=rgb(0,0,0),
    #     xaxt="n")

    #alternative solution
    Sys.setlocale("LC_TIME", "C") #http://stackoverflow.com/questions/8145886/change-time-locale-for-r
    dt <- strptime(paste(data_hpc_raw$Date, data_hpc_raw$Time), "%d/%m/%Y %H:%M:%S")
    plot(Date_time,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)", xaxt="n")
    r <- as.POSIXct(round(range(Date_time), "days"))
    axis.POSIXct(1, at=seq(r[1],r[2], by="day"), format="%a")
    
    #unfortunalely x-axis labels are not in English but in Czech, so I forced the English titles as follows
    plot(Global_active_power,
         ylab="Global Active Power (kilowatts)",
         xlab="",
         type="l",
         col=rgb(0,0,0),
         xaxt="n")
    axis(1, at=c(1,length(Global_active_power)/2,length(Global_active_power)),labels=c("Thu","Fri","Sat"))

## saving a plot
    dev.copy(png,file="plot2.png", width=480, height=480)
    dev.off()