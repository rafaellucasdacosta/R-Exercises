#install.packages("caret", dependencies = T)
library(recipes)
library(caret)
library(mlbench)

data(Soybean, package="mlbench")
bc <- Soybean[complete.cases(Soybean), ]  # faz uma cópia

soja <- subset(bc, (bc$Class == "brown-spot"  | bc$Class == "brown-stem-rot"))


# Convertendo fatores para números 
soja$Class <- ifelse(soja$Class == "brown-spot", 1, 0)

for(i in 2:36) {
  soja[, i] <- as.numeric(as.character(soja[, i]))
}

'%ni%' <- Negate('%in%')  # define a função 'not in' 
options(scipen=999)  # evita exibir em notação científica

# Preparando dados de treinamento e de teste
set.seed(100)
trainDataIndex <- createDataPartition(soja$Class, p=0.7, list = F)  # 70% training data
trainData <- soja[trainDataIndex, ]
testData <- soja[-trainDataIndex, ]

table(trainData$Class)   # exibir um resumo
trainData$Class <- as.factor(trainData$Class)
# utilizando down sampling
set.seed(100)   # fixa a semente para ser a mesma em cada execução 

down_train <- downSample(x = trainData[, colnames(trainData) %ni% "Class"], y = trainData$Class)

table(down_train$Class)   # exibir um resumo

# construindo o modelo
logitmod <- glm(Class ~ seed.tmt + area.dam + plant.growth, family = "binomial", data=down_train)
pred <- predict(logitmod, newdata = testData, type = "response")

y_pred_num <- ifelse(pred > 0.5, 1, 0)        # maior que 0.5 classifica como 1
y_pred <- factor(y_pred_num, levels=c(0, 1))  # transforma em fator 
y_act <- testData$Class                       # pega dados                   

mean(y_pred == y_act)                         # compara previsto com encontrado  

# resultado é o quanto o modelo está acertando
