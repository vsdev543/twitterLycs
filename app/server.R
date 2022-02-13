server <- function(input, output, session) {
  r<-reactiveValues(q=NULL)
  
  query <- reactive({getQueryString(session)})
  
  observeEvent(query(),{
    if(!is.null(query()$oauth_token)){
      r$q<-query()
    }else{
      r$q<-NULL
    }
  })
  
  user_token <- reactive({
    if (!is.null(r$q$oauth_token)) {

      access_token <-
        get_access_token(app, query()$oauth_token, query()$oauth_verifier)

      # Commenting below to match twitter
      user_token <- create_token(
        app = "",
        keys['consumer_key'],
        keys['consumer_secret'],
        access_token = access_token$oauth_token,
        access_secret = access_token$oauth_token_secret
      )
      user_token
      
      # list(oauth_token=access_token$oauth_token,oauth_token_secret=access_token$oauth_token_secret)
    } else{
      NULL
    }
  })
  
observe({
    if (is.null(user_token())) {
      
      output$main <- renderUI({
        url <- get_authorization_url(app, "https://twitter-lycs-x7977.ondigitalocean.app/")
        twitAuth_UI('lv0', url = url)
      })
      
      callModule(twitAuth, id = 'lv0')
      
    } else{
      
      output$main <- renderUI({
        dashTweet_UI(id='lv1',side=side,head=head,cont=cont,body=body)
      })
      
      callModule(dashTweet,"lv1",user_token=user_token,keys=keys,pos.words=pos.words,neg.words=neg.words,stop.wordsAr=stop.wordsAr)
    }
    
})
}