# required package installation
install.packages("quantmod")
library(quantmod)
install.packages("tidyquant")
library(tidyquant)
install.packages("tidyverse")
library(tidyverse)
install.packages("corrplot")
library(corrplot)
install.packages("datasets")
install.packages("forecast")
install.packages("graphics")
install.packages("stats")
install.packages("tseries")
library(forecast)
library(graphics)
library(stats)
library(tseries)
library(datasets)
library(forecast)

#setwd("D:/GitHub/portfolio/tracker")
getmysymbols<-function(x) {getSymbols(x,src = "yahoo",from="2017-01-30",to=as.Date(today()),auto.assign = FALSE,complete_cases = FALSE)}
getSymbols("TATAMOTORS.NS", src="yahoo")
tickers<-c("TATAMOTORS.NS")
x<-na.omit(TATAMOTORS.NS)
x
prices_adj<-lapply(tickers[TATAMOTORS.NS],getmysymbols)%>%map(Ad)%>%reduce(merge.xts)
prices_adj
head(prices_adj)
tail(prices_adj)
install.packages("zoo")
library(zoo)
table(unlist(lapply(prices_adj,class)))
plot(prices_adj)
summary(prices_adj)
tsdata<-ts(x,frequency=12)
tsdata
autoplot(tsdata)
x<-log(tsdata)
x
subset_tsdata<-window(tsdata)
subset_tsdata
as.numeric(subset_tsdata)
decompose(subset_tsdata)
y<-as.vector(tsdata)
y
#1)open ,2.close,3.high, 4. low,5. volume,6. adjusted
tata_closeprices<-TATAMOTORS.NS[,4]
tata_closeprices
plot(tata_closeprices)
acf(y)
pacf(y)
adf.test(y)
y<-diff(tsdata)
y
ndiffs(tsdata)

install.packages('fpp2', dependencies = FALSE)
install.packages("remotes")
remotes::install_github("robjhyndman/fpp2-package")
set.seed(10)
y<-ts(rnorm(100))
y
library(fpp2)
opar<-par(no.readonly = FALSE)
par(mfrow=c(2,3))
#par(opar)
ylim<-c(min(x),max(x))
summary(tsdata)
plot(x, main="raw time series")
plot(ma(x,3),main="simple moving average(k=3)",ylim=ylim)
plot(ma(x,7),main="simple moving average(k=7)",ylim=ylim)
plot(ma(x,13),main="simple moving average(k=13)",ylim=ylim)
S<-ma(x,order=16)
S
plot(S)
plot(forecast(S,5))

table(unlist(lapply(x,class)))
plot.ts(x[,c(2)])   
acf(x,lag.max = 20)
class(x)
install.packages("xts")
library(xts)
fita<-auto.arima(tata_closeprices,seasonal = FALSE)
tsdisplay(residuals(fita),lag.max = 40,main = "(0,1,1) residual model")
auto.arima(tata_closeprices,seasonal = FALSE)

fitA<-arima(tata_closeprices,order = c(5,1,4))
tsdisplay(residuals(fitA),lag.max = 40,main = "(5,2,4) residual model")
fitB<-arima(tata_closeprices,order = c(3,1,4))
tsdisplay(residuals(fitB),lag.max = 40,main = "(3,1,4) residual model")
fitC<-arima(tata_closeprices,order = c(3,1,3))
tsdisplay(residuals(fitC),lag.max = 40,main = "(3,1,3) residual model")
opar<-par(no.readonly = FALSE)
par(mfrow=c(2,2))
term<-5000
fcast1<-forecast(fitA,5,h=term)
plot(fcast1,ylab = "stock price",main = "Arima model of the tata motors")
fcast2<-forecast(fitB,5,h=term)
plot(fcast2)
fcast3<-forecast(fitC,5,h=term)
plot(fcast3)

