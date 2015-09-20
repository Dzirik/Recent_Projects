## Getting and Cleaning Data Peer Assessment

## a script for processing a data from 
## Human Activity Recognition Using Smartphones Data Set
## url: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## !!!! PREREQUISITES !!!!
## the "UCI HAR Dataset" from 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## is in current directory

# -1- testing directory structure ---------------------------------------------
    
    isDirectoryStructure<-file.exists("UCI HAR Dataset") & 
                          file.exists("UCI HAR Dataset/test") &
                          file.exists("UCI HAR Dataset/train") 
    
    if (isDirectoryStructure){
        print("Directory structure is OK.")
    }else{
        print("There is not appropriate directory structure.")
        print("Appropriate structure have to be:")
        print("- UCI HAR Dataset")
        print("-- test")
        print("-- train")
    }

# -2- reading necessary files -------------------------------------------------

    if (isDirectoryStructure){
        areFiles<-TRUE
        
        #testing data
        fileAddress<-"UCI HAR Dataset/test/X_test.txt"
        if(file.exists(fileAddress)){
            X_test<-read.table(fileAddress)
        }else{
            areFiles<-FALSE
            print(paste("File",fileAddress,"doesnt exists."))
        }
        
        fileAddress<-"UCI HAR Dataset/test/y_test.txt"
        if(file.exists(fileAddress)){
            y_test<-read.table(fileAddress)
        }else{
            areFiles<-FALSE
            print(paste("File",fileAddress,"doesnt exists."))
        }
        
        fileAddress<-"UCI HAR Dataset/test/subject_test.txt"
        if(file.exists(fileAddress)){
            subject_test<-read.table(fileAddress)
        }else{
            areFiles<-FALSE
            print(paste("File",fileAddress,"doesnt exists."))
        }
        
        #training data
        fileAddress<-"UCI HAR Dataset/train/X_train.txt"
        if(file.exists(fileAddress)){
            X_train<-read.table(fileAddress)
        }else{
            areFiles<-FALSE
            print(paste("File",fileAddress,"doesnt exists."))
        }
        
        fileAddress<-"UCI HAR Dataset/train/y_train.txt"
        if(file.exists(fileAddress)){
            y_train<-read.table(fileAddress)
        }else{
            areFiles<-FALSE
            print(paste("File",fileAddress,"doesnt exists."))
        }
        
        fileAddress<-"UCI HAR Dataset/train/subject_train.txt"
        if(file.exists(fileAddress)){
            subject_train<-read.table(fileAddress)
        }else{
            areFiles<-FALSE
            print(paste("File",fileAddress,"doesnt exists."))
        }
        
        #activity labels
        fileAddress<-"UCI HAR Dataset/activity_labels.txt"
        if(file.exists(fileAddress)){
            activity_labels<-read.table(fileAddress)
        }else{
            areFiles<-FALSE
            print(paste("File",fileAddress,"doesnt exists."))
        }
        
        #features
        fileAddress<-"UCI HAR Dataset/features.txt"
        if(file.exists(fileAddress)){
            features<-read.table(fileAddress)
        }else{
            areFiles<-FALSE
            print(paste("File",fileAddress,"doesnt exists."))
        }
        
        remove(fileAddress)
    }

# -3- mergin data -------------------------------------------------------------
    
    if(isDirectoryStructure & areFiles){
        #adding parts together
        X<-rbind(X_test,X_train)
        y<-rbind(y_test,y_train)
        subject<-rbind(subject_test,subject_train)
        #y=merge(y,activity_labels,by.x="V1",by.y="V1")
        baseData<-cbind(X,y,subject)
    
        #adding activities and names of features
        names(baseData)<-features[,2]
        names(baseData)[562]<-"activityCode"
        names(baseData)[563]<-"subject"
        baseData=merge(baseData,activity_labels,by.x="activityCode",by.y="V1")
        names(baseData)[564]<-"activityName"
        baseData$actSub<-paste(baseData$subject,baseData$activityName)
        
        #removing data
        remove(X_test,y_test,subject_test)
        remove(X_train,y_train,subject_train)
        remove(X,y,subject)
        remove(features, activity_labels)
    }

## NOTE: Full and named (features, activities) data set is now in variable "baseData"
##       Other variables were deleted

# -4- Extracting requested data
    
    if(isDirectoryStructure & areFiles){
        # relevant columns
        meanColumns<-grep("mean",names(baseData))
        stdColumns<-grep("std",names(baseData))
        subjectColumn<-grep("subject",names(baseData))
        activityCodeColumn<-grep("activityCode",names(baseData))
        activityNameColumn<-grep("activityName",names(baseData))
        
        #first dataset - measuremetns on mean and std    
        dataMeanStd<-baseData[,c(subjectColumn,activityNameColumn,meanColumns,stdColumns)]
        
        #second dataset - mean per activity and subject
        
        dataMeanActivitySubject<-tapply(baseData[,2],baseData$actSub,mean)
        for(i in 3:562){
            pom<-tapply(baseData[,i],baseData$actSub,mean)
            dataMeanActivitySubject<-cbind(dataMeanActivitySubject,pom)
        }
        
        rnames<-row.names(dataMeanActivitySubject)
        dataMeanActivitySubject<-data.frame(dataMeanActivitySubject)
        dataMeanActivitySubject<-cbind(rnames,dataMeanActivitySubject)
        row.names(dataMeanActivitySubject)<-NULL
        names(dataMeanActivitySubject)[1]<-"subjectActivity"
        names(dataMeanActivitySubject)[2:562]<-names(baseData)[2:562]
        
        row.names(dataMeanActivitySubject)<-NULL
        row.names(dataMeanActivitySubject)
        dataMeanActivitySubject<-data.frame(dataMeanActivitySubject)
        names(dataMeanActivitySubject)[1]<-"subjectActivity"
        names(dataMeanActivitySubject)[2:562]<-names(baseData)[2:562]   
        
        #removin variables
        remove(meanColumns,stdColumns,subjectColumn,activityCodeColumn,activityNameColumn,pom)
        remove(i,rnames)    
    }

# -5- Saving file 
    if(isDirectoryStructure & areFiles){
        write.table(dataMeanActivitySubject,file="secondDataSet.txt",row.names=FALSE)
    }
    