outliers.depth.trim<-function(fdataobj,nb=200,smo=0.05,trim=0.05,
dfunc=depth.mode,...){
 if (!is.fdata(fdataobj)) fdataobj=fdata(fdataobj)
 x<-fdataobj[["data"]]
 tt<-fdataobj[["argvals"]]
 rtt<-fdataobj[["rangeval"]]
 n<-nrow(fdataobj)
 m<-ncol(fdataobj)
 if (is.null(n) && is.null(m)) stop("ERROR IN THE DATA DIMENSIONS")
    cutoff<-median(quantile.outliers.trim(fdataobj,dfunc=dfunc,nb=nb,smo=smo,
    trim=trim,...))
    hay<-1
    outliers<-c()
    dep.out<-c()
    curvasgood<-fdataobj
    rownames(curvasgood[["data"]])=1:n
    while (hay==1){
         d=dfunc(curvasgood,trim=trim,...)$dep
          if (is.null(outliers)){dtotal<-d}
          fecha<-as.numeric(rownames(curvasgood[["data"]])[d<cutoff])
          elim<-which(d<cutoff)
          if (length(elim)>0){
             dep.out<-c(dep.out,d[d<cutoff])
             curvasgood<-curvasgood[-elim,]
             outliers<-c(outliers,fecha)
          }
        if (length(elim)==0 || length(outliers)>n/5){hay<-0}
    }
return(list("outliers"=outliers,"quantile"=cutoff,"Dep"=dtotal,"dep.out"=dep.out))
c(outliers,cutoff,dtotal,dep.out)
}