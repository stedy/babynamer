library(babynames)
library(shiny)
library(ggplot2)
library(dplyr)

file.remove("names.Rda")

server <- shinyServer(function(input, output) {

     input_sex <- ifelse(isolate(input$Sex) == "male", "M", "F")
     m <- subset(babynames, sex == input_sex)
     m$name = stringr::str_to_title(m$name)
     output$distPlot <- renderPlot({
      if(file.exists("names.Rda")){
       load("names.Rda")
      } else {
        names <- c()
      }
     session_name <- c(stringr::str_to_title(input$text))
     names <- c(names, session_name)
     save(names, file = "names.Rda")
      forplot <- m %>%
       subset(name %in% c(names, session_name)) %>%
       subset(year >= input$year_range[1] & year <= input$year_range[2]) %>%
       mutate(line_size = ifelse(name == session_name, 1.5, 1))
     
      ggplot(data=forplot, aes(x=year, y=prop, color=name)) + geom_line(aes(group = name)) +
       geom_line(aes(size=line_size), show.legend=F) +
       theme(axis.text=element_text(size=16),
              axis.title=element_text(size=18,face="bold")) +
       ylab(paste("Proportion of total", input$Sex, "babies born")) +
       ggtitle(paste("Babies born by year named", input$text, sep=" "))

   })

})
