run_analysis<-function( ){
#  read data from files
	x_test<-read.table("C:/Users/moi/Desktop/coursera homework/getting and cleaning data/week3/UCI HAR Dataset/test/X_test.txt")
	y_test<-read.table("C:/Users/moi/Desktop/coursera homework/getting and cleaning data/week3/UCI HAR Dataset/test/Y_test.txt")
	x_train<-read.table("C:/Users/moi/Desktop/coursera homework/getting and cleaning data/week3/UCI HAR Dataset/train/X_train.txt")
	y_train<-read.table("C:/Users/moi/Desktop/coursera homework/getting and cleaning data/week3/UCI HAR Dataset/train/X_train.txt")
	subject_test<-read.table("C:/Users/moi/Desktop/coursera homework/getting and cleaning data/week3/UCI HAR Dataset/test/subject_test.txt")
	subject_train<-read.table("C:/Users/moi/Desktop/coursera homework/getting and cleaning data/week3/UCI HAR Dataset/train/subject_train.txt")
	
	features<-read.table("C:/Users/moi/Desktop/coursera homework/getting and cleaning data/week3/UCI HAR Dataset/features.txt")
	labels<-read.table("C:/Users/moi/Desktop/coursera homework/getting and cleaning data/week3/UCI HAR Dataset/activity_labels.txt")

# get the index of features which include "std" or "mean"	
	fea_meanstd<-subset(features,agrepl("std",features$V2) | agrepl("mean",features$V2), select=c(1))

# names the colmuns of each data	
	colnames(x_test)<-featrue$V2
	colnames(y_test)<-"activity_labels"
	colnames(subject_test)<-"subjects"

	colnames(x_train)<-featrue$V2
	colnames(y_train)<-"activity_labels"
	colnames(subject_train)<-"subjects"

# combine the data into dataset
	test<-cbind(x_test,y_test)
	test<-cbind(test,subject_test)
	train<-cbind(x_train,y_train)
	train<-cbind(train,subject_train)

	dataset<-rbind(test,train)
	
# redefine the colmuns of dataset
	cols<-c("activity_labels")
	cols<-c(as.character(featrue$V2),cols)
	colnames(dataset)<-cols

# get the data which only includes features in fea_meanstd  from dataset 
	data<-dataset[,c(fea_meanstd$V1,562,563)]

# merge the data and labels
	ndata<-merge(data,labels,by.x="activity_labels",by.y="V1",all=TRUE)
	ndata<-ndata[,2:89]

	col1<-colnames(ndata)
	col1<-c(col1[1:87],"activity_labels")
	colnames(ndata)<-col1

	tidydata<-aggregate(ndata[1:86], by=list(ndata$subjects, ndata$activity_labels), FUN=mean, na.rm=TRUE)
	
}
