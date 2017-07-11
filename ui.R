#devtools::install_github("daattali/shinyjs")
#install.packages("shinyBS")
#install.packages("shinythemes")
#install.packages("shinyjs")
library(shinyBS) #for bootstrap methods
#library(shinythemes) #for background layout
library(shiny) 
library(shinyjs) #javascript for hovers
options(shiny.deprecation.messages=FALSE)

shinyUI(fluidPage(
  #tagList( 
  useShinyjs(),
  navbarPage("Gene Set Omic Analysis", id = "page-nav",
    theme = shinytheme("sandstone"),
    #shinythemes::themeSelector(),
    #collapsable = TRUE,
    tabPanel("Run",
    
    HTML('<center><img src="./top.png"></center>'),

      # Column 1: Data Files
    div(id = "inputs", column( 4, offset = 2,
            br(),
  
            
            div( style = "height: 85px;",
              fileInput('dataFile', 'Genomic Data File *required', multiple = T, width = "85%",accept = c('text/csv','text/comma-separated-values','text/tab-separated-values', 'text/plain','.csv','.tsv'))),
           

            div( style = "height: 85px;", fileInput('classFile','Sample Class File *required',width = "85%",
                accept = c('text/csv','text/comma-separated-values','text/tab-separated-values', 'text/plain','.csv','.tsv'))),
            div(style = "height: 85px;", fileInput('gmtFile','Gene Sets  (GMT file) *required',width = "85%",
                accept = c('text/csv','text/comma-separated-values','text/tab-separated-values', 'text/plain','.csv','.tsv'))),
            
            #hidden things
            a(id = "toggleAdvanced", "Show/hide multi-omic data inputs"),
            hidden(div(id = "advanced",
              div(style = "height: 85px;",fileInput('dataFile2','DNA Sequencing Data.',width = "85%",
                  accept = c('text/csv','text/comma-separated-values','text/tab-separated-values', 'text/plain','.csv','.tsv'))),
              div(style = "height: 85px;",
                fileInput( 'dataFile3','Copy Number Variation Data.',
                  width = "85%", accept = c('text/csv','text/comma-separated-values','text/tab-separated-values', 'text/plain','.csv','.tsv'))),
              div(style = "height: 85px;", fileInput('dataFile4','Other Genomic Data.', width = "85%",
                  accept = c('text/csv','text/comma-separated-values','text/tab-separated-values', 'text/plain','.csv','.tsv'))),
              div(style = "height: 85px;", fileInput('dataFile5', 'Other Genomic Data.',width = "85%",
                  accept = c('text/csv','text/comma-separated-values','text/tab-separated-values', 'text/plain','.csv','.tsv'))))),
          
           # div(
           #   style = "height: 30px;",
           #   checkboxInput("checkbox", label = "Include Hallmark Analysis", value = FALSE)
           # ),
           # bsPopover(
           #   id = "checkbox",
           #   title = "Select if you want to run the Hallmark Analysis",
           #   content = "The hallmark gene sets represent 50 important pathways curated by the Molecular Signatures Database with the goal of reducing redundancy " ,
           #   placement = "right",
           #   trigger = "hover"
           # ),
            div(
              style = "height: 30px;",
              checkboxInput("GFRN_sigs", label = "Include Bild Lab Signatures", value = FALSE)
            ),
            bsPopover(
              id = "GFRN_sigs",
              title = "Select if you want to run all Bild lab signatures",
              content = "Bild lab signatures consists of experimentallt generated RNA-sequencing signatures from the growth factor receptor network " ,
              placement = "right",
              trigger = "hover"
            )
            # check boxes. 
            #div( style = "height: 30px;",checkboxInput("checkbox", label = "Include Hallmark Analysis", value = FALSE)),
            # bsPopover( id = "checkbox",
             # title = "Select if you want to run the Hallmark Analysis",
              #content = "The hallmark gene sets represent 50 important pathways curated by the Molecular Signatures Database with the goal of reducing redundancy " ,
              #placement = "right", trigger = "hover"),
            
            div(style = "height: 30px;", checkboxInput("GFRN_sigs", label = "Include Bild Lab Signatures", value = FALSE)),
            bsPopover(id = "GFRN_sigs", title = "Select if you want to run all Bild lab signatures",
              content = "Bild lab signatures consists of experimentallt generated RNA-sequencing signatures from the growth factor receptor network " ,
              placement = "right", trigger = "hover" ))),
    
      # Column 2: Variance 
      column(4, offset = 1,
        br(),
        div(style = "height: 85px;",numericInput("Variance","% Variance to Filter",value = 10,width = "70%",min = 1, max = 90)),
        div(style = "height: 85px;",numericInput( "LowExpression","% Low Gene Expression to Filter",value = 10,width = "70%",min = 1,max = 90)),
        div(style = "height: 65px;",textInput('results_h', value = "smacneil88@gmail.com ",width = "70%", label = 'E-mail Address')),
        br(),
      
        # more hidden stuff  
        a(id = "toggleAdvanced2", "Show/hide additional paramters"),
        hidden(
        div( id = "advanced2",div(style = "height: 85px;", selectInput( 'Algorithm',label = 'Machine Learning Algorithm.',choices = c("svm", "rf"),width = "70%")),
        div( style = "height: 85px;", numericInput("CrossValidation","# of Cross Validations", value = 5,min = 1,width = "70%", max = 5)),
        div(style = "height: 85px;", numericInput( 'Iterations',label = 'Number of Iterations.', value = 10, min = 1,
            width = "70%",max = 1000)))),
        br(),
        br(),

        actionButton("run","GO", width = "35%", icon("paper-plane"),
        style = "color: white; background-color:#2FA4A4;  border-color: grey"),
        bsTooltip( id = "run", title = "Click Go! once files are uploaded", placement = "right", trigger = "hover"),
        actionButton( "refresh","Refresh",width = "35%", icon("refresh"))),
          #style = "color: black; background-color:  grey;  border-color: grey; padding:9px")),
    
    
    column(12, HTML('<center><img src="./about.png"></center>')),
    column(12,offset=5, actionButton(inputId='link', label="GSOA Manuscript", icon = icon("wikipedia-w"),
              onclick ="window.open('https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-015-0189-4', '_blank')")),
    column(12,HTML('<center><img src="./howitwork_code.png"></center>')),

    
    column(12, offset=2,
        actionButton(inputId='link', label="GSOA-APP Docker", icon = icon("github"),
              onclick ="window.open('https://hub.docker.com/r/shelleymac/gsoa_docker/', '_blank')"),
        actionButton(inputId='link', label="GSOA-Phyton Bitbucket", icon = icon("bitbucket"),
              onclick ="window.open('https://bitbucket.org/srp33/gsoa', '_blank')"),
        actionButton(inputId='link', label="GSOA-R Github Repo", icon = icon("rocket"),
              onclick ="window.open('https://github.com/smacneil1/R-GSOA', '_blank')"),
        actionButton(inputId='link', label="GSOA Development WIKI", icon = icon("wikipedia-w"),
              onclick ="window.open('http://gsoa.wikidot.com/', '_blank')"),

        br(), br()
        ),
    
    
     column(12,
    h4('Developed @ the University of Utah', align = "center", style = "font-family: 'Montserrat'"))),
    
    
    
    # Other Tabs
   
    tabPanel("Instructions",includeMarkdown("doc/instructions.md")),
    tabPanel("Contact", includeMarkdown("doc/contact.md")) )))
    #tabPanel(title=HTML("</a></li><li><a href='http://gsoa.wikidot.com/' target='_blank'>GSOA Development Wiki Page")) 
    #tabPanel("About", includeMarkdown("doc/about.md")),
    #tabPanel("Demo Data",includeMarkdown("doc/demo.md")),
    #tabPanel("Code", includeMarkdown("doc/code.md")),        
    #tabPanel("Software Updates", includeMarkdown("doc/version.md"))



### NOT USING


        #HTML('<h4> File Validation </h4>'),
        #verbatimTextOutput("path"),
        #allows for message errors
        #singleton(tags$head(tags$script(src = "message-handler.js"))),
        #htmlOutput("sessionInfo"),
        #dataTableOutput("results")

      #HTML('<center><h3> An easy-to-use web application for discovering "multi-omic" pathway-level phenotypes. </h4></center>'),
      #br(),
      #HTML('<center><h4> GSOA utilizes machine learning algorithms and integrate evidence from "omic" data (RNA, RNA, methylation, ect.) to identify gene set differences between given phenotypes. </h4></center>'),
      


#h5('Please load your data files and specify GSOA parameters. See "Instructions for Use" section for file and parameter details',align= "left"),
#h5('To run GSOA with', a(href = 'https://drive.google.com/open?id=0B-HGhGW-uF4AODNhMnVHSmUwdHM', 'Demo Files', target="_blank"), 'download all 3 files from drive,', 'and upload.', style="color:black"),

#column(4, wellPanel(
#  offset=10,
#  h5('Download data after run is complete.',style="color:black"),
#  downloadButton('downloadData', 'Download Results'))),

# put things side by side
#fluidRow(
#  column(8,
#  p('', style="border:0.1px; border-style:solid; border-color:grey; padding: 0.01em;background:grey"),
#  column(8,
#         numericInput("LowExpression", "% Low Gene Expression to Filter",value=10, min = 1, max = 90, width="50%"))),

#HTML('<style> hr.hasClass{ border-width: 4px; border:0px; height:1.5px; background-color:red;} </style> <hr class="hasClass">'),

#not sure
#tags$head(tags$style(HTML("#page-nav > li:first-child { display: none; }" ))),

#Demo File Information
#column(12, ,
#style = " font-size:17px"
#HTML('<hr style="color: black; size="10";>'),
#tags$div(HTML("<center><strong>GSOA identifies gene sets that differ between two phenotypes by integrating evidence from multi-omic data using machine learning algorithms</strong></center>")),


#p('', style="border:0.75px; border-style:solid; border-color:black; padding: 0.02em;background:black"),
#HTML('<style> hr.hasClass{ border-width: 4px; border:0px; height:1.5px; background-color:black;} </style> <hr class="hasClass">'),
#h3('Gene Set Omic Analysis (GSOA)', style="color:white;border:1px; border-style:solid; border-color:grey; padding: 0.5em; background:#54b4eb", align= "center"),

# sidebarLayout(
#   sidebarPanel(
#
#   # main panel
#     mainPanel(
#     tags$style(type="text/css",
#                ".shiny-output-error { visibility: hidden; }",
#                ".shiny-output-error:before { visibility: hidden; }"),
#     ,
#     #verbatimTextOutput("outFile"),
#     plotOutput('plot1')
#   ))
#
# )

#checkboxInput('header', 'Header', TRUE),
#radioButtons('sep', 'Separator',
#            c(Comma=',',
#               Semicolon=';',
#               Tab='\t'),
#             ','),



#uiOutput("newWindowContent", style = "display: none;"),
    
#tags$script(HTML("
      #$(document).ready(function() {
      #  if(window.location.hash != '') {
       #   $('div:not(#newWindowContent)').hide();
        #  $('#newWindowContent').show();
         # $('#newWindowContent').appendTo('body');
        #}
    #  })
    #")),
     # a(href = "#Instructions", target = "_blank",
    #  actionButton("instructions", "instructions")
    #),
      #HTML('<center><img src="./gsoa_front_page.png"></center>'),


    #div( style="width:80%; display:inline-block; vertical-align: middle; height: 85px",
    #fileInput("chosenfile", label = h5("File input"), accept = ".csv")),
   #div( style="display:inline-block; vertical-align: center;",
    #bsButton("q1", label = "", icon = icon("question"), style = "info", size = "extra-small"),
    #bsPopover(id = "q1", title = "Tidy data", content = paste0("You should read the ", a("tidy data paper",  href = "http://vita.had.co.nz/papers/tidy-data.pdf",
                                 #target="_blank")), placement = "right", trigger = "click", options = list(container = "body") )),
