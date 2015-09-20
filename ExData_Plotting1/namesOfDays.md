Solution od days of week in Czech/English
========================================================

## From plot 2

Prerequisites - data are available

```r
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
```

```
## Error: unsupported URL scheme
```

```r
    data_hpc_raw <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";")
```

```
## Warning: cannot open zip file
## 'C:\Users\Jiri\AppData\Local\Temp\RtmpCa8Crn\file129c6c013d46'
```

```
## Error: cannot open the connection
```

```r
unlink(temp)   

Global_active_power<-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",3]
```

```
## Error: object 'data_hpc_raw' not found
```

```r
Global_active_power<-as.numeric(as.character(Global_active_power))
```

```
## Error: object 'Global_active_power' not found
```

```r
Date_time <-data_hpc_raw[data_hpc_raw[,1]=="1/2/2007" | data_hpc_raw[,1]=="2/2/2007",c(1,2)]
```

```
## Error: object 'data_hpc_raw' not found
```

```r
Date_time <- strptime(paste(Date_time$Date,Date_time$Time), 
                          format="%d/%m/%Y %H:%M:%S") 
```

```
## Error: object 'Date_time' not found
```

Correct colution

```r
Sys.setlocale("LC_TIME", "C") #http://stackoverflow.com/questions/8145886/change-time-locale-for-r
```

```
## [1] "C"
```

```r
dt <- strptime(paste(data_hpc_raw$Date, data_hpc_raw$Time), "%d/%m/%Y %H:%M:%S")
```

```
## Error: object 'data_hpc_raw' not found
```

```r
plot(Date_time,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)", xaxt="n")
```

```
## Error: object 'Date_time' not found
```

```r
r <- as.POSIXct(round(range(Date_time), "days"))
```

```
## Error: object 'Date_time' not found
```

```r
axis.POSIXct(1, at=seq(r[1],r[2], by="day"), format="%a")
```

```
## Error: object 'r' not found
```

Alternative solution


```r
plot(Global_active_power,
     ylab="Global Active Power (kilowatts)",
     xlab="",
     type="l",
     col=rgb(0,0,0),
     xaxt="n")
```

```
## Error: object 'Global_active_power' not found
```

```r
axis(1, at=c(1,length(Global_active_power)/2,length(Global_active_power)),labels=c("Thu","Fri","Sat"))
```

```
## Error: object 'Global_active_power' not found
```
