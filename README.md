# Alexa Swift
##### (aka. League Assistant)

### Project Overview
_./Sources/main.swift_

**Description**: This project provides a demonstration of how to develop for the Amazon Echo. With this skill the user is capable to ask Alexa for the statistics of the enemy team in League of Legends the video game, and know what they should care about.

##### Prerequisites
- Apple computer
- XCode 8.3.3
- Swift 3.1
- [Ngrok](https://ngrok.com/)
- [CouchDB](http://couchdb.apache.org/)
- [An Amazon developer account](https://developer.amazon.com/)
- [A League of Legends developer API Key](https://developer.riotgames.com/)

##### Alexa configuration
Go to the [Alexa Developer Console](https://developer.amazon.com/edw/home.html#/) and select _Alexa Skill Kit_.
Click _Add new skill_.

The next steps show you what information is necessary on each Alexa tab. If you notice there is information _missing_ just leave the field blank or their default values.

**Skill Information**
Name: lol assistant
Invokation name: `League assistant`

**Interaction Model**
- Click _Launch Skill Builder_
- Go to _Code editor_ tab.
- Drag and drop [InteractionModel.json](./InteractionModel.json).
- Apply changes.
- Save and build model.
- Go back to the skill configuation by clicking _Configuration_

**Configuration**
- Service Endpoint Type: `HTTPS`
- Geographical region: `North America`/`Europe` (Any)
* You will get the endpoint using ngrok. Check the next step for that.

##### Getting local endpoint
In your terminal run
`ngrok http 8081`
You will get a https endpoint, which is the hook for your skill.

###### CouchDB configuration
Before running the project, is recommended to have CouchDB running.
By default, it runs on port _5984_.
- Open you manager ( http://127.0.0.1:5984/_utils/ ), and under the admin panel create a new admin. Remember this credentials.
- Log out from CouchDB by clicking _Log out_ just at the bottom of the page, left side.
- Open again the manager and log in with your credentials.
- Go to _Databases_ and _Create Database_.
- Input the name of your desired Database and click _Create_. Super easy, right? _Relax_.


##### Setting up the project
- Within your terminal clone the project, and cd the project directory.
- Copy _./Sources/AppConstants.swift.example_ as _./Sources/AppConstants.swift_
- Edit that file by adding your LoL API Key in the _apiKey_ filed.
- Edit the host and port of the database if it doesn't match with your configuration.
- Add the name of the database in the _name_ field, also input your _admin_ and _password_ database in their respective fields.

##### Building and running the project
Install dependences and build project with
`swift build`

If successful, run the project with
`./.build/debug/SwiftEcho`
Your server will run into the port 8081.

Also, you can generate the xcode project using.
`swift package generate-xcodeproj`

* Note, if you are coding withing xode, be sure to change the scheme before running. You should select the last _SwiftEcho_, and run on _My Mac_.

#### Testing the skill
Back in the Alexa portal, we have the _Test_ tab under your skill configuration. Go there.
In the Service simulatour you can try different stuff to test your skill.
Some examples are:
`open league asistant`
`log in with ID two zero eight one seven three eight and region Latin America North`
`give me statistics`


🍻
