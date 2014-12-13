shinyUI(navbarPage(
                   tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "app.css")),

                   tabPanel("DEMO",
                            tags$div(class="demo",
                            fluidRow(
                                    h2("1. You: Type into the text box below"),
                                     textInput("text", label=""),
                                     img(src='ios-keyboard.png')
                                    ),
                            fluidRow(
                                    h2("2. Model: Top 3 predictions"),
                                    column(2, h5('Choice 2'),
                                           verbatimTextOutput("word2")),
                                    column(2, h5('SINGLE TOP PREDICTION'),
                                           tags$div(class="singleTop",
                                                    verbatimTextOutput("word1"))),
                                    column(2, h5('Choice 3'),
                                           verbatimTextOutput("word3"))
                                    )
                            )),
                        tabPanel("Documentation",
                            fluidRow(column(6,
                                            includeMarkdown("documentation.md")
                            )
                            )
                   )
)
)
