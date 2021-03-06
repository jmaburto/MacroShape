# subplots of Figure 1, combined in Inkscape, where annotation is added.

# generic relationship conditioned on a particular age and time.
# y = m*x+b
set.seed(1)
b     <- .1
m     <- .6
error <- rnorm(30) * .1
x     <- runif(30)
y     <- m * x + b + error
ba    <- lm(y~x)$coef
xnew  <- c(.05,.95)
ynew  <- ba[1] + xnew * ba[2]

pdf(here("Figures","GenericLinear.pdf"),width=3,height=2)
par(mai = c(.1,.1,0,.1))
plot(NULL, type = "n", xlim = c(0,1), ylim = c(0,1), xlab = "", ylab = "", axes = FALSE)
points(x,y,pch=16,cex=.5)
segments(xnew[1],ynew[1],xnew[2],ynew[2],lwd=2)
segments(min(x),0,max(x),0,lwd=1.5)
segments(0,min(y),0,max(y),lwd=1.5)
dev.off()


# generic pointer
pdf(here("Figures","GenericFieldElement.pdf"),width=3,height=3)
par(mai=c(.1,.1,.1,.1))
plot(NULL, type = "n", xlim = c(0,1), ylim = c(0,1), xlab = "", ylab = "", axes = FALSE, asp = 1)
rect(0, 0, 1, 1)
rect(pad, pad, 1 - pad, 1 - pad, border = gray(.5), lty = "7373")
draw_field_element(age = 0, year = 0, interval = 1, slope = ba[2], lwd = 2)
points(.5, .5, pch = 16)
lines(
		x = cos(seq(0, 2 * pi, length = 200)) * .4 + .5,
		y = sin(seq(0, 2 * pi, length = 200)) * .4 + .5, 
		col = "#ADD8E6", lty = "6363", lwd = 2)
dev.off()


# ------------------------
# lexis grid on left
years               <- seq(1950, 2015, by = 5)
ages                <- seq(0, 100, by = 5)

# crosses
crossrad            <- .6
xl                  <- years - crossrad
xr                  <- years + crossrad
yl                  <- ages - crossrad
yu                  <- ages + crossrad
xl[xl < min(years)] <- min(years)
xr[xr > max(years)] <- max(years)
yl[yl < min(ages)]  <- min(ages)
yu[yu > max(ages)]  <- max(ages)

pdf(here("Figures","LexisCellSelection.pdf"),width=3*.8,height=3+.2)
par(mai=c(.2,.2,.1,.1))
plot(NULL, xlim = range(years), ylim = range(ages),type = "n", xlab = "", ylab = "", asp = 1, axes = FALSE)

sapply(years, function(x,yu,yl,...){
			segments(x,yu,x,yl,...)
		},yu=yu,yl=yl,col=gray(.5),lwd=.7)
sapply(ages, function(y,xr,xl,...){
			segments(xr,y,xl,y,...)
		},xr=xr,xl=xl,col=gray(.5),lwd=.7)
text(years[years%%10==0],min(ages),years[years%%10==0],pos=1,xpd=TRUE,cex=.6)
text(min(years),ages[ages%%10==0],ages[ages%%10==0],pos=2,xpd=TRUE,cex=.6)
rect(2000,50,2005,55,border=gray(.2))
rect(min(years),min(ages), max(years), max(ages),xpd=TRUE)
dev.off()

# end
