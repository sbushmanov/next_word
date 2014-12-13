shinyServer(
        function(input, output) {
                predictions <- reactive({string <- .strip2(input$text)
                                         key2 <- vocab[string,]
                                         k <- key2$tok # 2 last words
                                         k[is.na(key2$N)] <- "<UNK>"
                                         k2 <- paste(k, collapse=" ") # 2 last with <UNK>
                                         k1 <- k[2] # 1 last with <UNK>
                                         modelPrediction <- c(tModel[.(k2),Value], c(NA, NA))[1:3]
                                         if (all(is.na(modelPrediction))) {modelPrediction <- c(bModel[.(k1), Value], c(NA,NA))[1:3]}
                                         the <- c("the", "the", "the")
                                         modelPrediction[is.na(modelPrediction)] <- the[is.na(modelPrediction)]
                                         modelPrediction
                })
                output$word1 <- renderText({
                        predictions()[1]
                        })
                output$word2 <- renderText({
                        predictions()[2]
                })
                output$word3 <- renderText({
                        predictions()[3]
                })
        })
