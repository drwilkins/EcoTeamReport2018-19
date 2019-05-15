require(lubridate);require(ggplot2);require(plotly);require(dplyr); require(rmarkdown)
r<-read.csv("EcoTeam Recycling Data - Collection Data.csv",as.is=c("Paper","TrashItms"))
r$Date<-mdy(r$Date)
r$Paper<-as.numeric(r$Paper)
r$TrashItms<-as.numeric(r$TrashItms)
head(r)
r<-subset(r,Team!="?"&Team!="")

comb= r %>% group_by(Date,Team) %>% summarise(Paper=sum(Paper,na.rm=T),TrashItms=sum(TrashItms,na.rm=T))
comb$ImpurityRt<-comb$Paper/comb$TrashItms*100 #trash items/100lbs
(paperRecycling <- ggplot(comb,aes(x=Date,y=Paper,col=Team,shape=Team))+geom_point()+theme_bw()+geom_line(aes(group=Team))+ylab("Paper Recycled (lbs)")  )

ggplotly(paperRecycling)


(purity <- ggplot(comb,aes(x=Date,y=TrashItms,col=Team,shape=Team))+geom_point()+theme_bw()+geom_line(aes(group=Team))+ylab("TrashItms")  )

ggplotly(purity)


  