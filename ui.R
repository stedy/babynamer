fluidPage(
   titlePanel("Baby names over time according to US Census"),

   sidebarLayout(
     sidebarPanel(
     textInput("text", label = h3("Enter name"), value = "Zachary"),
    selectInput('Sex', label = h3('Sex'),
                c(male='M',
                  female='F')),
    sliderInput("year_range", label = h3("Year Range"), min = 1880,
                max = 2015, sep = "",
                value = c(1880, 2015)),

     submitButton(text = "Submit")
   ),
   mainPanel(
     plotOutput("distPlot")
   ))
)

