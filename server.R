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
  
  # set run button to inactive if there are no files
  #observe({
  #shinyjs::toggleState("runButton", !is.null(input$dataFile) && input$dataFile != "")
  #})
  
  #this w
  observeEvent(input$refresh, {
    reset("inputs")
  })

 # what happens when you press run.   
 observeEvent(input$run, {
   
   
  
  # pop up message dialog boxes if files arn't present
  #if (is.null(input$dataFile) && is.null(input$classFile) && is.null(input$gmtFile)) {shinyjs::alert("Missing Data File, Class File, and GMT File")}
  #if (is.null(input$dataFile) && is.null(input$classFile) && !is.null(input$gmtFile)) {shinyjs::alert("Missing Data File and Class File")}
  #if (is.null(input$dataFile) && !is.null(input$classFile) && is.null(input$gmtFile)) {shinyjs::alert("Missing Data File and GMT File")}
  #if (!is.null(input$dataFile) && is.null(input$classFile) && is.null(input$gmtFile)) {shinyjs::alert("Missing Class File and GMT File")}
  #if (is.null(input$dataFile) && !is.null(input$classFile) && !is.null(input$gmtFile)) {shinyjs::alert("Missing Data File")}
  #if (!is.null(input$dataFile) && is.null(input$classFile) && !is.null(input$gmtFile)) {shinyjs::alert("Missing Class File")}
  #if (!is.null(input$dataFile) && !is.null(input$classFile) && is.null(input$gmtFile)) {shinyjs::alert("Missing GMT File")}
  #if (!is.null(input$dataFile) && !is.null(input$classFile) && !is.null(input$gmtFile)){
      #{shinyjs::alert("GSOA is running. An e-mail with your results will be sent shortly. ")
   
   Sys.sleep(2)
   file.copy(input$dataFile$datapath, paste("/data", input$dataFile$name, sep="/"))   
   file.copy(input$classFile$datapath, paste("/data", input$classFile$name, sep="/"))
   file.copy(input$gmtFile$datapath, paste("/data", input$gmtFile$name, sep="/"))
   
   variables = list(dataFilePath = paste("/data", input$dataFile$name, sep="/"),
                    classFilePath=paste("/data", input$classFile$name, sep="/"),
                    gmtFilePath=paste("/data", input$gmtFile$name, sep="/"))
   
   POST('http://gsoa:5000/',body = variables , encode="json")
   
   output$path <- renderText(input$dataFile$datapath)
    
    
     })
 
 
 
 
})


#output$console <- renderPrint({
#  capture.output(GSOA_ProcessFiles(dataFilePath = input$dataFile$datapath, classFilePath = input$classFile$datapath,  gmtFilePath = input$gmtFile_hallmarks$datapath))
#})



 
  
  
    #output$results <- renderDataTable({ 
    #  cbind(names = rownames(GSOA_h), GSOA_h) 
    #})
      
      #validate(
      #need(input$dataFile, 'No Data File Found'),
      #need(input$classFile, 'No Class File Found'),
      #need(input$gmtFile_hallmarks, 'No GMT File Found'),
      #c("Data File:", input$dataFile$name, '\n', input$classFile$name,'\n',  input$gmtFile_hallmarks$name ))
      #output$path <- renderText({ 'See Results Below' })
         #if (is.null(input$dataFile))
        #  return(NULL)
          
  #withProgress(message = 'Running GSOA and Generating Report', {
    # Make sure we have at least one file

    # check to make sure all required files are there 


    
    
  
  #observeEvent(input$runButton, {

#downloadHandler(filename, content, contentType = NA, outputArgs = list())


# this works.
#output$download <- downloadHandler(
#  filename = function() {
#    paste("GSOA", Sys.Date(), ".csv", sep="")
#  },
#  content = function(file) {
#    write.csv(GSOA , file) #this part works
#  })

# Not using
#    observeEvent(input$showInputs, {
#      output$alg <- renderText({
#        paste("Algorithm:", input$Algorithm, "\n", "Voom:", input$Voom, "\n", "Cores:", input$Cores,"\n", "Iteration:", input$Iterations, "\n", "Variance:", input$Variance, "\n", "LowExpression:", input$LowExpression, "\n", "CrossValidation:",  input$CrossValidation )
#      })
#    })   
    


    #validate(
    #need(input$dataFile,  ),
    #need(input$classFile, 'Please upload a class file '),
    #need(input$gmtFile, 'Please select a gmt file')
    #)


#output$file1 <- renderTable({
# inFile <- input$file1
#  if (is.null(inFile))
# return(NULL)
# filw = read.csv(inFile$datapath, header = input$header,
# sep = input$sep, quote = input$quote)
#boxplot(file)
#})

#myData <- reactive({
#    inFile <- input$file1
#    if (is.null(inFile)) return(NULL)
#    data <- read.csv(inFile$datapath, header = T, sep= "\t", row.names = 1)
#    data
#  })

