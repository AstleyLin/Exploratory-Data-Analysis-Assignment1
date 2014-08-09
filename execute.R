### Notes
#1. please make sure the DataDir contains data 
#2. In order to accerate the executing speed, I add the DataCache.fg to function so that it need not read data each time
#   (but the first time is not avoided....). You can set DataCache.fg=T to enable that (defalt is false).

DataDir <- "D:\\Miscellaneous\\Google~1\\eLearn\\Johns Hopkins_Data Science\\Exploratory Data Analysis\\Assignment"
for(file in paste(DataDir, "/plot", 1:4, ".R", sep="")) source(file)
plot1(DataDir, DataCache.fg=T)
plot2(DataDir, DataCache.fg=T)
plot3(DataDir, DataCache.fg=T)
plot4(DataDir)

