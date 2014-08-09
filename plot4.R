plot4 <- function(DataDir, PlotDir=DataDir,   
                    width=480, height=480, SavePNG.fg=T) 
{
    # plot chart
    setwd(PlotDir)
    if(SavePNG.fg) png(file="plot4.png", width=width, height=height, units="px")
    par(mfrow=c(2,2))
    plot2(DataDir=DataDir, DataCache.fg=T, 
            SavePNG.fg=F, Variable="Global_active_power", main="", xlab="", ylab="Global Active Power")
    plot2(DataDir=DataDir, DataCache.fg=T, 
            SavePNG.fg=F, Variable="Voltage", main="", xlab="datetime", ylab="Voltage")
    plot3(DataDir=DataDir, DataCache.fg=T, 
            SavePNG.fg=F)
    plot2(DataDir=DataDir, DataCache.fg=T, 
            SavePNG.fg=F, Variable="Global_reactive_power", main="", xlab="datetime", ylab="Global_reactive_power")
    if(SavePNG.fg) dev.off()
}
