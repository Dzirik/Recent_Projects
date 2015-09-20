## CREATION OF PLOT 1 FROM COURESERA'S Exploratory Data Analysis Course Project 1

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

    if (dispDatasetsInRStudio){
        View(Global_active_power) #displaying dataset in Rstudio    
    }
    
## creating a plot
    hist(Global_active_power,
         xlab="Global Active Power (kilowatts)",
         ylab="Frequency",
         main="Global Active Power",
         col="red")
    
## saving a plot
    dev.copy(png,file="plot1.png", width=480, height=480)
    dev.off()