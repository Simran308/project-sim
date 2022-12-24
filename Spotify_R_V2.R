#Setting the packages
install.packages("plotly")
install.packages("funModeling")
library(moments)
library(ggplot2)
library(GGally)
library(rpart)
library(rpart.plot)
library(caret)
library(dplyr)
library(plotly)
library(funModeling)
spotify.df <- read.csv("Spotify.csv")
View(spotify.df)

#DATA PREPARATION

#Understanding the dataset
summary(spotify.df)
str(spotify.df)
sapply(colnames(spotify.df), function(x) class(spotify.df[[x]]))
lapply(spotify.df, unique)
View(spotify.df)

#The dataset has over 0.5 million observations. We will now trim the dataset based on release date between 16th April 2020 and 2021 and this dataset will henceforth be used for analysis
spotify2.df<-spotify.df[spotify.df$release_date >= "2020-04-16" & spotify.df$release_date <= "2021-04-16", ]

#Understanding the trimmed dataset
summary(spotify2.df)
str(spotify2.df)
lapply(spotify2.df, unique)
head(spotify2.df)
glimpse(spotify2.df)
colnames(spotify2.df)
dim(spotify2.df)

#Data cleaning
colSums(is.na(spotify2.df)) # No NA values
#Checking for white-spaces in the numeric/ integer columns
nrow(spotify2.df[spotify2.df$popularity=="",])
nrow(spotify2.df[spotify2.df$duration_ms=="",])
nrow(spotify2.df[spotify2.df$explicit=="",])
nrow(spotify2.df[spotify2.df$danceability=="",])
nrow(spotify2.df[spotify2.df$energy=="",])
nrow(spotify2.df[spotify2.df$key=="",])
nrow(spotify2.df[spotify2.df$mode=="",])
nrow(spotify2.df[spotify2.df$speechiness=="",])
nrow(spotify2.df[spotify2.df$acousticness=="",])
nrow(spotify2.df[spotify2.df$instrumentalness=="",])
nrow(spotify2.df[spotify2.df$liveness=="",])
nrow(spotify2.df[spotify2.df$valence=="",])
nrow(spotify2.df[spotify2.df$tempo=="",])
nrow(spotify2.df[spotify2.df$time_signature=="",])
#Checking for duplicated values
sum(duplicated(spotify2.df))

length(unique(spotify2.df$id))   #counting unique songs

#Adding a hit/ Not hit column based on popularity
hist(spotify2.df$popularity, breaks=20, xlab = "popularity")
summary(spotify2.df$popularity)
#we will remove these songs with popularity score of 0
spotify2.df["popularity"][spotify2.df["popularity"] == 0] <- NA
summary(spotify2.df$popularity)
spotify2.df <- spotify2.df[complete.cases(spotify2.df),]

dim(spotify2.df)
spotify2.df<-spotify2.df %>% mutate(popularity_cat =
                                      case_when(popularity <= 50 ~ 0, 
                                                popularity > 50 ~ 1))


ggplot(spotify2.df, aes(factor(popularity_cat)))+geom_bar()+xlab("popularity_cat")
table(spotify2.df$popularity_cat)

summary(spotify2.df$popularity_cat)
summary(spotify2.df)

numerical_cols = c("duration_ms","danceability","energy","loudness","speechiness","acousticness"
                        ,"instrumentalness","liveness","valence","tempo","popularity")
spotify2_num.df<-spotify2.df %>% select(numerical_cols)
data.frame(mean=sapply(spotify2_num.df, mean,na.rm=TRUE),
           median=sapply(spotify2_num.df, median,na.rm=TRUE),
           min=sapply(spotify2_num.df, min,na.rm=TRUE),
           max=sapply(spotify2_num.df, max,na.rm=TRUE),
           standardev=sapply(spotify2_num.df,sd,na.rm=TRUE))

#Histrogram
plot_num(spotify2_num.df)
#Skewness check
skewness(spotify2_num.df$duration_ms,na.rm=TRUE)
skewness(spotify2_num.df$danceability,na.rm=TRUE)
skewness(spotify2_num.df$energy,na.rm=TRUE)
skewness(spotify2_num.df$loudness,na.rm=TRUE)
skewness(spotify2_num.df$speechiness,na.rm=TRUE)
skewness(spotify2_num.df$acousticness,na.rm=TRUE)
skewness(spotify2_num.df$instrumentalness,na.rm=TRUE)
skewness(spotify2_num.df$liveness,na.rm=TRUE)
skewness(spotify2_num.df$valence,na.rm=TRUE)
skewness(spotify2_num.df$tempo,na.rm=TRUE)
skewness(spotify2_num.df$popularity,na.rm=TRUE)

#boxplot
boxplot(duration_ms~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "duration_ms",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)
boxplot(danceability~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "danceability",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)
boxplot(energy~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "energy",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)
boxplot(loudness~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "loudness",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)
boxplot(speechiness~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "speechiness",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)
boxplot(acousticness~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "acousticness",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)
boxplot(instrumentalness~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "instrumentalness",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)
boxplot(liveness~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "liveness",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)
boxplot(valence~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "valence",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)
boxplot(tempo~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "tempo",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)
boxplot(popularity~popularity_cat, data = spotify2.df,
        main = "Variation",
        xlab = "popularity",
        ylab = "Popularity Category (0=Not Hit, 1=Hit)",
        col = "green",
        border = "blue",
        horizontal = TRUE,
        notch = TRUE
)

#finding popular artists
popular_artists <- spotify2.df %>% group_by(Artist = artists) %>%
  summarise(No_of_tracks = n(),Popularity = mean(popularity))  %>% 
  filter(No_of_tracks > 1) %>%
  arrange(desc(Popularity)) %>%
  top_n(15, wt = Popularity) %>% 
  ggplot(aes(x = Artist, y = Popularity)) +
  geom_bar(stat = "identity") +
  coord_flip() + labs(title = "popular artists overall", x = "Artists", y = "Popularity")

ggplotly(popular_artists)

# top artists in based on popularity
top_10_artists <- spotify2.df %>% 
  group_by(Artist = artists) %>%
  summarise(No_of_tracks = n(), Popularity = mean(popularity)) %>% 
  filter(No_of_tracks > 1) %>%
  arrange(desc(Popularity)) %>%
  top_n(10, wt = Popularity)



#Clubbing features into usable buckets
index_date_cols = c("id", "name", "artists","id_artists","release_date")
cat_cols = c("mode","key","explicit")
classification_cols = c("duration_ms","danceability","energy","loudness","speechiness","acousticness"
                        ,"instrumentalness","liveness","valence","tempo","mode","key","explicit","popularity_cat")
num2_cols = c("popularity")

#CLASSIFICATION

# partition
spotify_class.df<-spotify2.df %>% select(classification_cols)
set.seed(1)
train.index <- sample(c(1:dim(spotify_class.df)[1]), dim(spotify_class.df)[1]*0.6)  
train.df <- spotify_class.df[train.index, ]
valid.df <- spotify_class.df[-train.index, ]
#decision tree
default.ct <- rpart(popularity_cat ~ ., data = train.df ,method = "class")
# plot tree
prp(default.ct, type = 1, extra = 2, under = TRUE, split.font = 1, varlen = -10)
# count number of leaves
length(default.ct$frame$var[default.ct$frame$var == "<leaf>"])

deeper.ct <- rpart(popularity_cat ~ ., data = train.df, method = "class", cp = -1, minsplit = 1)
length(deeper.ct$frame$var[deeper.ct$frame$var == "<leaf>"])

# classify records in the validation data.
default.ct.point.pred.train <- predict(default.ct,train.df,type = "class")
# generate confusion matrix for training data
confusionMatrix(default.ct.point.pred.train, as.factor(train.df$popularity_cat))

### repeat the code for the validation set, and the deeper tree
default.ct.point.pred.valid <- predict(default.ct,valid.df,type = "class")
confusionMatrix(default.ct.point.pred.valid, as.factor(valid.df$popularity_cat))

deeper.ct.point.pred.train <- predict(deeper.ct,train.df,type = "class")
confusionMatrix(deeper.ct.point.pred.train, as.factor(train.df$popularity_cat))
deeper.ct.point.pred.valid <- predict(deeper.ct,valid.df,type = "class")
confusionMatrix(deeper.ct.point.pred.valid, as.factor(valid.df$popularity_cat))

set.seed(1)
cv.ct <- rpart(popularity_cat ~ ., data = train.df, method = "class", cp = 0.00001, minsplit = 1, xval = 5)  # minsplit is the minimum number of observations in a node for a split to be attempted. xval is number K of folds in a K-fold cross-validation.
printcp(cv.ct)  # Print out the cp table of cross-validation errors. The R-squared for a regression tree is 1 minus rel error. xerror (or relative cross-validation error where "x" stands for "cross") is a scaled version of overall average of the 5 out-of-sample errors across the 5 folds.
#pruned.ct <- prune(cv.ct, cp = 0.00107157)
pruned.ct <- prune(cv.ct, cp = 0.00107157)
length(pruned.ct$frame$var[pruned.ct$frame$var == "<leaf>"])

printcp(pruned.ct)

# classify records in the validation data.
pruned.ct.point.pred.train <- predict(pruned.ct,train.df,type = "class")
# generate confusion matrix for training data
confusionMatrix(pruned.ct.point.pred.train, as.factor(train.df$popularity_cat))

### repeat the code for the validation set, and the deeper tree
pruned.ct.point.pred.valid <- predict(pruned.ct,valid.df,type = "class")
confusionMatrix(pruned.ct.point.pred.valid, as.factor(valid.df$popularity_cat))

library(randomForest)
## random forest
rf <- randomForest(as.factor(popularity_cat) ~ ., data = train.df, ntree = 500, 
                   mtry = 4, nodesize = 5, importance = TRUE)  

## variable importance plot
varImpPlot(rf, type = 1)

## confusion matrix
rf.pred1 <- predict(rf, train.df)
confusionMatrix(rf.pred1, as.factor(train.df$popularity_cat))
rf.pred <- predict(rf, valid.df)
confusionMatrix(rf.pred, as.factor(valid.df$popularity_cat))

library(adabag)

train.df$popularity_cat <- as.factor(train.df$popularity_cat)

set.seed(1)
boost <- boosting(popularity_cat ~ ., data = train.df)
pred1 <- predict(boost, train.df)
confusionMatrix(as.factor(pred1$class), as.factor(train.df$popularity_cat))
pred <- predict(boost, valid.df)
confusionMatrix(as.factor(pred$class), as.factor(valid.df$popularity_cat))

# regression.
logit.reg <- glm(popularity_cat ~ ., data = train.df, family = "binomial") 
options(scipen=999)
summary(logit.reg)
formula(logit.reg)

logit.reg.pred <- predict(logit.reg, valid.df, type = "response")
logit.reg.pred.classes <- ifelse(logit.reg.pred > 0.5, 1, 0)
confusionMatrix(as.factor(logit.reg.pred.classes), as.factor(valid.df$popularity_cat))

# model selection
full.logit.reg <- glm(popularity_cat ~ ., data = train.df, family = "binomial") 
empty.logit.reg  <- glm(popularity_cat ~ 1,data = train.df, family= "binomial")
summary(empty.logit.reg)

backwards = step(full.logit.reg)
summary(backwards)
backwards.reg.pred <- predict(backwards, valid.df, type = "response")
backwards.reg.pred.classes <- ifelse(backwards.reg.pred > 0.5, 1, 0)
confusionMatrix(as.factor(backwards.reg.pred.classes), as.factor(valid.df$popularity_cat))

forwards = step(empty.logit.reg,scope=list(lower=formula(empty.logit.reg),upper=formula(full.logit.reg)), direction="forward",trace=0)
formula(forwards)
formula(backwards)
forwards.reg.pred <- predict(forwards, valid.df, type = "response")
forwards.reg.pred.classes <- ifelse(forwards.reg.pred > 0.5, 1, 0)
confusionMatrix(as.factor(forwards.reg.pred.classes), as.factor(valid.df$popularity_cat))

stepwise = step(empty.logit.reg,scope=list(lower=formula(empty.logit.reg),upper=formula(full.logit.reg)), direction="both",trace=1)
formula(stepwise)
stepwise.reg.pred <- predict(stepwise, valid.df, type = "response")
stepwise.reg.pred.classes <- ifelse(stepwise.reg.pred > 0.5, 1, 0)
confusionMatrix(as.factor(stepwise.reg.pred.classes), as.factor(valid.df$popularity_cat))

forcorr_cols=c("duration_ms","danceability","energy","loudness","speechiness","acousticness"
                ,"instrumentalness","liveness","valence","tempo","popularity")
Spotify_Corr.df=spotify2.df %>% select(forcorr_cols)
Cor_spotify=data.frame(cor(Spotify_Corr.df, use = "complete.obs"))
Cor_spotify
plot(Spotify_Corr.df)
plot(Cor_spotify)
ggcorr(Spotify_Corr.df, hjust = 1)

#Clustering
cluster_cols=c("id","duration_ms","danceability","energy","loudness","speechiness","acousticness"
               ,"instrumentalness","liveness","valence","tempo")
spotify_cluster.df <- spotify2.df %>% select(cluster_cols)
row.names(spotify_cluster.df) <- spotify_cluster.df[,1]
spotify_cluster.df <- spotify_cluster.df[,-1]
View(spotify_cluster.df)
summary(spotify_cluster.df)

spotify_cluster.df.norm <- sapply(spotify_cluster.df, scale)
row.names(spotify_cluster.df.norm) <- row.names(spotify_cluster.df)

# PLotting elbow chart
k.max <- 50
data <- spotify_cluster.df.norm
wss <- sapply(1:k.max, 
              function(k){kmeans(data, k, nstart=50,iter.max = 15 )$tot.withinss})
wss
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")

km <- kmeans(spotify_cluster.df.norm,8)
#Plots for g
# plot an empty scatter plot
plot(c(0), xaxt = 'n', ylab = "", type = "l", 
     ylim = c(min(km$centers), max(km$centers)), xlim = c(0, 10))

# label x-axes
axis(1, at = c(1:10), labels = names(spotify_cluster.df))

# plot centroids
for (i in c(1:8))
  lines(km$centers[i,], lty = i, lwd = 3, col = ifelse(i %in% c(1, 3, 5),
                                                        "black", "dark grey"))

# name clusters
text(x =0.3, y = km$centers[, 1], labels = paste("Cluster", c(1:8)))



