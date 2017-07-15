# Alexa Swift
##### (aka. League Assistant)

### Project Overview
_./Sources/main.swift_

**Description**: Demostration of the Amazon Echo. With this skill the user is capable to ask Alexa for the stadistics of the teams in his/her current game of League of Legends.

###### Prerequisites
XCode 8.3.3
Swift 3.1
[Ngrok](https://ngrok.com/)
[CouchDB](http://couchdb.apache.org/)
[An Amazon developer account](https://developer.amazon.com/)
[A League of Legends developer API Key](https://developer.riotgames.com/)

###### Alexa configuration
Go to the [Alexa Developer Console](https://developer.amazon.com/edw/home.html#/) and select _Alexa Skill Kit_.
Click on _Add new skill_.
**Skill information**
Name: lol assistant
Invokation name: `League assistant`
**Interaction model**
1. Click _Launch Skill Builder_
2. Go to _Code editor_ tab.
3. Drag and drop [InteractionModel.json](./InteractionModel.json).
4. Apply changes.
5. Save model.
6. Build model.
7. Configuration.
**Configuration**
Service Endpoint Type: HTTPS
Geographical region: North America/Europe (Any)
* You will get the endpoint using ngrok.

###### Getting local endpoint
Run
`ngrok http 8080`
You will get a https endpoint, that is the hook for your skill.

###### Setting up the project
Within your terminal clone the project, and go the project directory.
Rename _./Sources/AppConstants.swift.example_ into _./Sources/AppConstants.swift_
Edit that file bya adding your LoL API Key.

###### Building and running the project
```
swift build
swift package generate-xcodeproj
./.build/debug/SwiftEcho
```
Your server will be running into the port 8080.

**TODO**
###### CouchDB configuration
###### Versioning recomendations

🍻
