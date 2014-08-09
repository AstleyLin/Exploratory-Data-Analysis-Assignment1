plot3 <- function(DataDir, PlotDir=DataDir, 
                    width=480, height=480, DataCache.fg=F, SavePNG.fg=T) 
{
#(RoughMemorySize <- 2075259*9*8/(2^20))
    TimePeriod.vt <- c("1/2/2007","2/2/2007")
    TimeFormat <- "%d/%m/%Y"
    CacheExist.fg <- is.element("household_power_consumption", ls(envir=.GlobalEnv))

    # import data
    if(DataCache.fg && CacheExist.fg) {
        data.df <- household_power_consumption
    } else {
        if(CacheExist.fg) rm(household_power_consumption, envir=.GlobalEnv)
        setwd(DataDir)
        data.vt <- readLines("household_power_consumption.txt")
        range.vt <- range(c(grep(TimePeriod.vt[1], data.vt), grep(TimePeriod.vt[2], data.vt)), na.rm=T)
        head.df <- read.table("household_power_consumption.txt", nrows=1, header=T, sep=";", na.strings="?")
        data.df <- read.table("household_power_consumption.txt", skip=range.vt[1]-1, nrows=diff(range.vt)+1, header=F, sep=";", na.strings="?")
        names(data.df) <- names(head.df)
        if(DataCache.fg & !CacheExist.fg) household_power_consumption <<- data.df
    }

    # filter data (since grep doesn't guarantee right duration)
    Date.vt <- strptime(data.df[,"Date"], TimeFormat)
    Period.vt <- strptime(TimePeriod.vt, TimeFormat)
    select.fg <- Date.vt >= Period.vt[1] & Date.vt <= Period.vt[2] & !is.na(Date.vt)
    data.df <- data.df[select.fg,]
    
    # plot chart
    setwd(PlotDir)
    DateTime.vt <- strptime(paste(data.df[,"Date"], data.df[,"Time"]), paste(TimeFormat, "%H:%M:%S"))
    if(SavePNG.fg) png(file="plot3.png", width=width, height=height, units="px")
    Variables <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
    Color <- c("black","red","blue")
    names(Color) <- Variables
    range.vt <- range(as.matrix(data.df[,Variables]), na.rm=T)
    plot(DateTime.vt[c(1,length(DateTime.vt))], range.vt, type="n", axes=T, main = "", ylab = "Energy sub metering", xlab="")
    for(Var in Variables) lines(DateTime.vt, data.df[, Var], col=Color[Var])
    legend("topright", legend=Variables, col=Color, lty=1)    
    if(SavePNG.fg) dev.off()
}
