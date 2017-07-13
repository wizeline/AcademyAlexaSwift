#####


TODO:
Alexa configuration
  Create an account in https://developer.amazon.com/
  Sign in
  Go to https://developer.amazon.com/edw/home.html#/skills
  Add a new skill

  Skill information
    Name: LoL assistant
    Invocation name: League assitant

  Interaction model:
    Intent schema:
  ```{
      "intents": [
        {
          "intent": "AMAZON.CancelIntent"
        },
        {
          "intent": "AMAZON.HelpIntent"
        },
        {
          "intent": "AMAZON.StopIntent"
        },
        {
          "intent": "login"
        },
        {
          "intent": "logout"
        },
        {
          "slots": [
            {
              "name": "user_region",
              "type": "region"
            }
          ],
          "intent": "region"
        },
        {
          "slots": [
            {
              "name": "user_team",
              "type": "team"
            }
          ],
          "intent": "statistics"
        }
      ]
      }```

  Slot Types:
    region:
      North America
      Europe West
      Europe Nordic and East
      Europe East
      Brazil
      Turkey
      Russia
      Latin America North
      Latin America South
      Oceania
      Japan
      Korea

    team:
      allied
      enemy
      my

    sample utterances:
      login log in
      login log me in
      logout switch account
      logout log out
      region {user_region}
      statistics statistics about {user_team} team



CouchDB setup
