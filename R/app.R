library(shiny)

generate_story <- function(noun, verb, adjective, adverb) {
  cat("----------------------\n", "gen story fn\n", "________________" )
  glue::glue(
    "
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  "
  )
}

ui <- fluidPage(
  titlePanel("Mad Libs Game"),
  sidebarLayout(

    sidebarPanel(
      cat("----------------------\n", "sidebar\n", "________________" ),
      textInput("noun1", "Enter a noun:", ""),
      textInput("verb", "Enter a verb:", ""),
      textInput("adjective", "Enter an adjective:", ""),
      textInput("adverb", "Enter an adverb:", ""),
      actionButton("submit", "Create Story")
    ),
    mainPanel(
      h3("Your Mad Libs Story:"),
      textOutput("story")
    )
  )
)

server <- function(input, output) {
  cat("----------------------\n", "server\n", "________________" )
  story <- eventReactive(input$submit, {
    cat("----------------------\n", "story server fn\n", "________________" )
    generate_story(input$noun1, input$verb, input$adjective, input$adverb)
  })
  output$story <- renderText({
    story()
  })
}

shinyApp(ui = ui, server = server)
