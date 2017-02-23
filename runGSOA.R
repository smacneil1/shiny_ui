#trim column names

library(GSOA)

dataFile= commandArgs()[7]
classFile = commandArgs()[8]
outFile = commandArgs()[9]
gmtFile= commandArgs() [10]

print(classFile)
print(dataFile)
print(gmtFile)
print(outFile)

classificationAlgorithm="svm"
numCrossValidationFolds=5
numRandomIterations=1000
numCores=20

#tcga_brca_tumor_gene_expression<-"~/Documents/PhDProjects/Multipathway_Modeling/Data/PANCAN24_BRCA_1119_TPMlog2.txt"
#test<-data.frame(fread(tcga_brca_tumor_gene_expression), check.names=F,row.names=1)
#write.table(test,"/Users/shelleymacneil/Documents/PhDProjects/Jasmine_BRCA_BRCA/PANCAN24_BRCA_1119_TPMlog2_shortnames.txt" , col.names=NA, row.names= T, quote=FALSE, sep="\t")


GSOA_ProcessFiles(dataFile, classFile, gmtFile, outFile, classificationAlgorithm, numCrossValidationFolds,numRandomIterations, numCores)

#run this with the follow script on terminal 
#nohup Rscript ./GSOA_Jasmine_BRCA.txt > nohup_Jasmine.out 2>&1&



