# Shiny Server Code for GSOA-Shiny 
# Shelley MacNeil

library(shiny)
library(httr)
#library(devtools)
#library(GSOA)
#library(e1071)
#library(ROCR)
#library(rsconnect)
#library(rmarkdown)
#library(ggplot2)

# By default, the file size limit is 5MB. It can be changed by setting this option. Here we'll raise limit to 9MB.
options(shiny.maxRequestSize = 9*1024^2)

# main server function
shinyServer(function(input, output, session) {
  
  # for the additional parameters
  onclick("toggleAdvanced", toggle(id = "advanced", anim = TRUE))
  onclick("toggleAdvanced2", toggle(id = "advanced2", anim = TRUE))
  
  #this w
  observeEvent(input$refresh, {
    reset("inputs")
  })
  
  # what happens when you press run.   
  observeEvent(input$run, {
    
    output$path <- renderText(input$GFRN_sigs)
    # pop up message dialog boxes if files arn't present
    
    if (input$GFRN_sigs==FALSE) {
    if (is.null(input$dataFile) && is.null(input$classFile) && is.null(input$gmtFile)) {shinyjs::alert("Missing Data File, Class File, and GMT File")}
    if (is.null(input$dataFile) && is.null(input$classFile) && !is.null(input$gmtFile)) {shinyjs::alert("Missing Data File and Class File")}
    if (is.null(input$dataFile) && !is.null(input$classFile) && is.null(input$gmtFile)) {shinyjs::alert("Missing Data File and GMT File")}
    if (!is.null(input$dataFile) && is.null(input$classFile) && is.null(input$gmtFile)) {shinyjs::alert("Missing Class File and GMT File")}
    if (is.null(input$dataFile) && !is.null(input$classFile) && !is.null(input$gmtFile)) {shinyjs::alert("Missing Data File")}
    if (!is.null(input$dataFile) && is.null(input$classFile) && !is.null(input$gmtFile)) {shinyjs::alert("Missing Class File")}
    if (!is.null(input$dataFile) && !is.null(input$classFile) && is.null(input$gmtFile)) {shinyjs::alert("Missing GMT File")}
    if (!is.null(input$dataFile) && !is.null(input$classFile) && !is.null(input$gmtFile))
    {shinyjs::alert("GSOA is running. \n An e-mail with your results will be sent shortly. ")
      
      # add to all file names
      #system("xxd -l 10 -p /dev/urandom")   
      system(paste("cp",input$dataFile$datapath, paste("/home/smacneil/gsoa_data", input$dataFile$name, sep="/"), sep=" "))
      system(paste("cp",input$classFile$datapath, paste("/home/smacneil/gsoa_data", input$classFile$name, sep="/"), sep=" "))
      system(paste("cp",input$gmtFile$datapath, paste("/home/smacneil/gsoa_data", input$gmtFile$name, sep="/"), sep=" "))
      
      dataFilePath1 = paste("/data", input$dataFile$name, sep="/")
      
      # copy the files over to the data folder and make a variable for their paths
      if (!is.null(input$dataFile2)){system(paste("cp",input$dataFile2$datapath, paste("/data", input$dataFile2$name, sep="/"), sep=" "))
        dataFilePath2 = paste("/data", input$dataFile2$name, sep="/")}
      if (!is.null(input$dataFile3)){system(paste("cp",input$dataFile3$datapath, paste("/data", input$dataFile3$name, sep="/"), sep=" "))
        dataFilePath3 = paste("/data", input$dataFile3$name, sep="/")}
      if (!is.null(input$dataFile4)){system(paste("cp",input$dataFile4$datapath, paste("/data", input$dataFile4$name, sep="/"), sep=" "))
        dataFilePath4 = paste("/data", input$dataFile4$name, sep="/")}
      if (!is.null(input$dataFile5)){system(paste("cp",input$dataFile5$datapath, paste("/data", input$dataFile5$name, sep="/"), sep=" "))
        dataFilePath5 = paste("/data", input$dataFile5$name, sep="/")}
      
      #send the variabes depending on how many files 
      if (!is.null(input$dataFile) && is.null(input$dataFile2) && is.null(input$dataFile3) && is.null(input$dataFile4) && is.null(input$dataFile5))
      {variables = list(dataFilePath = paste("/data", input$dataFile$name, sep="/"), 
                        classFilePath=paste("/data", input$classFile$name, sep="/"),
                        gmtFilePath=paste("/data", input$gmtFile$name, sep="/"), email=input$results_h, 
                        classificationAlgorithm=input$Algorithm, numCrossValidationFolds=input$CrossValidation, numRandomIterations=input$Iterations, removePercentLowestExpr=input$LowExpression, 
                        removePercentLowestVar=input$Variance, checkbox=input$GFRN_sigs )}
      
      if (!is.null(input$dataFile) && !is.null(input$dataFile2) && is.null(input$dataFile3) && is.null(input$dataFile4) && is.null(input$dataFile5))
      {   variables = list(dataFilePath = c(dataFilePath1,  dataFilePath2), classFilePath=paste("/data", input$classFile$name, sep="/"),
                           gmtFilePath=paste("/data", input$gmtFile$name, sep="/"), email=input$results_h, 
                           classificationAlgorithm=input$Algorithm, numCrossValidationFolds=input$CrossValidation, numRandomIterations=input$Iterations, removePercentLowestExpr=input$LowExpression, 
                           removePercentLowestVar=input$Variance, checkbox=input$GFRN_sigs)}
      
      
      if (!is.null(input$dataFile) && !is.null(input$dataFile2) && !is.null(input$dataFile3) && is.null(input$dataFile4) && is.null(input$dataFile5))
      {   variables = list(dataFilePath = c(dataFilePath1,  dataFilePath2, dataFilePath3),
                           classFilePath=paste("/data", input$classFile$name, sep="/"),
                           gmtFilePath=paste("/data", input$gmtFile$name, sep="/"), email=input$results_h, 
                           classificationAlgorithm=input$Algorithm, numCrossValidationFolds=input$CrossValidation, numRandomIterations=input$Iterations, removePercentLowestExpr=input$LowExpression, 
                           removePercentLowestVar=input$Variance, checkbox=input$GFRN_sigs)}
      
      if (!is.null(input$dataFile) && !is.null(input$dataFile2) && !is.null(input$dataFile3) && !is.null(input$dataFile4) && is.null(input$dataFile5))
      {   variables = list(dataFilePath = c(dataFilePath1,  dataFilePath2, dataFilePath3, dataFilePath4),
                           classFilePath=paste("/data", input$classFile$name, sep="/"),
                           gmtFilePath=paste("/data", input$gmtFile$name, sep="/"), email=input$results_h, 
                           classificationAlgorithm=input$Algorithm, numCrossValidationFolds=input$CrossValidation, numRandomIterations=input$Iterations, removePercentLowestExpr=input$LowExpression, 
                           removePercentLowestVar=input$Variance, checkbox=input$GFRN_sigs)}
      
      if (!is.null(input$dataFile) && !is.null(input$dataFile2) && !is.null(input$dataFile3) && !is.null(input$dataFile4) && !is.null(input$dataFile5))
      {   variables = list(dataFilePath = c(dataFilePath1,  dataFilePath2, dataFilePath3, dataFilePath4, dataFilePath5),
                           classFilePath=paste("/data", input$classFile$name, sep="/"),
                           gmtFilePath=paste("/data", input$gmtFile$name, sep="/"), email=input$results_h, 
                           classificationAlgorithm=input$Algorithm, numCrossValidationFolds=input$CrossValidation, numRandomIterations=input$Iterations, removePercentLowestExpr=input$LowExpression, 
                           removePercentLowestVar=input$Variance, checkbox=input$GFRN_sigs)}
      
      POST('http://155.101.145.54:5000/',body = variables , encode="json")
      
      #      output$path <- renderText(c(input$dataFile$datapath,input$dataFile2$name) )
      
    }
      
    }
    
    if (input$GFRN_sigs==TRUE) {
      
      if (is.null(input$dataFile) && !is.null(input$classFile)) {shinyjs::alert("Missing Data File")}
      if (is.null(input$classFile) && !is.null(input$dataFile)) {shinyjs::alert("Missing Class File")}
      if (is.null(input$dataFile) && is.null(input$classFile) ) {shinyjs::alert("Missing Data File and Class File")}
      
      if (!is.null(input$dataFile) && !is.null(input$classFile)) {shinyjs::alert("GSOA is running. \n An e-mail with your results will be sent shortly. ")
        
        # add to all file names
        #system("xxd -l 10 -p /dev/urandom")   
        system(paste("cp",input$dataFile$datapath, paste("/home/smacneil/gsoa_data", input$dataFile$name, sep="/"), sep=" "))
        system(paste("cp",input$classFile$datapath, paste("/home/smacneil/gsoa_data", input$classFile$name, sep="/"), sep=" "))
        system(paste("cp",input$gmtFile$datapath, paste("/home/smacneil/gsoa_data", input$gmtFile$name, sep="/"), sep=" "))
 
        dataFilePath1 = paste("/data", input$dataFile$name, sep="/")
        
        # copy the files over to the data folder and make a variable for their paths
        if (!is.null(input$dataFile2)){system(paste("cp",input$dataFile2$datapath, paste("/data", input$dataFile2$name, sep="/"), sep=" "))
          dataFilePath2 = paste("/data", input$dataFile2$name, sep="/")}
        if (!is.null(input$dataFile3)){system(paste("cp",input$dataFile3$datapath, paste("/data", input$dataFile3$name, sep="/"), sep=" "))
          dataFilePath3 = paste("/data", input$dataFile3$name, sep="/")}
        if (!is.null(input$dataFile4)){system(paste("cp",input$dataFile4$datapath, paste("/data", input$dataFile4$name, sep="/"), sep=" "))
          dataFilePath4 = paste("/data", input$dataFile4$name, sep="/")}
        if (!is.null(input$dataFile5)){system(paste("cp",input$dataFile5$datapath, paste("/data", input$dataFile5$name, sep="/"), sep=" "))
          dataFilePath5 = paste("/data", input$dataFile5$name, sep="/")}
        
        #send the variabes depending on how many files 
        if (!is.null(input$dataFile) && is.null(input$dataFile2) && is.null(input$dataFile3) && is.null(input$dataFile4) && is.null(input$dataFile5))
        {variables = list(dataFilePath = paste("/data", input$dataFile$name, sep="/"), 
                          classFilePath=paste("/data", input$classFile$name, sep="/"),
                          gmtFilePath=paste("/data", input$gmtFile$name, sep="/"), email=input$results_h, 
                          classificationAlgorithm=input$Algorithm, numCrossValidationFolds=input$CrossValidation, numRandomIterations=input$Iterations, removePercentLowestExpr=input$LowExpression, 
                          removePercentLowestVar=input$Variance, checkbox=input$GFRN_sigs )}
        
        if (!is.null(input$dataFile) && !is.null(input$dataFile2) && is.null(input$dataFile3) && is.null(input$dataFile4) && is.null(input$dataFile5))
        {   variables = list(dataFilePath = c(dataFilePath1,  dataFilePath2), classFilePath=paste("/data", input$classFile$name, sep="/"),
                             gmtFilePath=paste("/data", input$gmtFile$name, sep="/"), email=input$results_h, 
                             classificationAlgorithm=input$Algorithm, numCrossValidationFolds=input$CrossValidation, numRandomIterations=input$Iterations, removePercentLowestExpr=input$LowExpression, 
                             removePercentLowestVar=input$Variance, checkbox=input$GFRN_sigs)}
        
        
        if (!is.null(input$dataFile) && !is.null(input$dataFile2) && !is.null(input$dataFile3) && is.null(input$dataFile4) && is.null(input$dataFile5))
        {   variables = list(dataFilePath = c(dataFilePath1,  dataFilePath2, dataFilePath3),
                             classFilePath=paste("/data", input$classFile$name, sep="/"),
                             gmtFilePath=paste("/data", input$gmtFile$name, sep="/"), email=input$results_h, 
                             classificationAlgorithm=input$Algorithm, numCrossValidationFolds=input$CrossValidation, numRandomIterations=input$Iterations, removePercentLowestExpr=input$LowExpression, 
                             removePercentLowestVar=input$Variance, checkbox=input$GFRN_sigs)}
        
        if (!is.null(input$dataFile) && !is.null(input$dataFile2) && !is.null(input$dataFile3) && !is.null(input$dataFile4) && is.null(input$dataFile5))
        {   variables = list(dataFilePath = c(dataFilePath1,  dataFilePath2, dataFilePath3, dataFilePath4),
                             classFilePath=paste("/data", input$classFile$name, sep="/"),
                             gmtFilePath=paste("/data", input$gmtFile$name, sep="/"), email=input$results_h, 
                             classificationAlgorithm=input$Algorithm, numCrossValidationFolds=input$CrossValidation, numRandomIterations=input$Iterations, removePercentLowestExpr=input$LowExpression, 
                             removePercentLowestVar=input$Variance, checkbox=input$GFRN_sigs)}
        
        if (!is.null(input$dataFile) && !is.null(input$dataFile2) && !is.null(input$dataFile3) && !is.null(input$dataFile4) && !is.null(input$dataFile5))
        {   variables = list(dataFilePath = c(dataFilePath1,  dataFilePath2, dataFilePath3, dataFilePath4, dataFilePath5),
                             classFilePath=paste("/data", input$classFile$name, sep="/"),
                             gmtFilePath=paste("/data", input$gmtFile$name, sep="/"), email=input$results_h, 
                             classificationAlgorithm=input$Algorithm, numCrossValidationFolds=input$CrossValidation, numRandomIterations=input$Iterations, removePercentLowestExpr=input$LowExpression, 
                             removePercentLowestVar=input$Variance, checkbox=input$GFRN_sigs)}
        
        POST('http://155.101.145.54:5000/',body = variables , encode="json")
        
        #      output$path <- renderText(c(input$dataFile$datapath,input$dataFile2$name) )
        
      }
    }
    
    
  })
  
  
})
