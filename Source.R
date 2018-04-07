library(tidyr)
#Data
data  = read.csv('Parking_Violations_Issued_in_September_2017.csv', header = T)
colnames(data)[1] <- "X"
data = subset(data, select = c(X,Y,DAY_OF_WEEK,VIOLATION_CODE,VIOLATION_DESCRIPTION,LOCATION,STREETSEGID,TICKET_ISSUE_DATE))
data$DAY_OF_WEEK = weekdays(as.Date(data$TICKET_ISSUE_DATE))
data = separate(data = data, col = TICKET_ISSUE_DATE, into = c("DATE", "TIME"), sep = 'T')
data$TIME = substr(data$TIME, 0, 5)
data$HOUR = as.integer(substr(data$TIME, 0, 2))
data$DATETIME = as.POSIXct(paste(data$DATE, data$TIME), format = "%Y-%m-%d %H:%M")
data = subset(data, select = -c(DATE,TIME))

#Create a list with the violation descriptions of frequency more than 100 
vio_sub <- table(data[, 'VIOLATION_DESCRIPTION']) %>% as.data.frame
vio_sub <- vio_sub[with(vio_sub, order(-Freq)),] %>% as.data.frame
vio_sub <- subset(vio_sub, Freq >= 100)
vio_list = unique(unlist(vio_sub$Var1))
