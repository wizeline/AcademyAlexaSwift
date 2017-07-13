import Kitura
import SwiftyJSON

// Create a new router
let router = Router()
let utils = Utils()
let alexa = AlexaController()

router.all("/", middleware: BodyParser())

// Handle HTTP GET requests to /
router.get("/") {
    request, response, next in
    response.send("Kitura is ready to rock&roll.")
    print(request)
    next()
}

// Handle HTTP POST requests to /
router.post("/") {
    request, response, next in
    alexa.setup(response)

    guard let parsedBody = request.body else {
        next()
        return
    }
    
    switch(parsedBody) {
    case .json(let jsonBody):
        
        let alexaReq = AlexaRequest(jsonBody)
        
        switch alexaReq.intent! {
        case "login":
                alexa.say(speech: "What is your summoner ID?", reprompt: "I didn't hear you")
            
            break;
        case "logout":
                alexa.bye(speech: "Good bye")
            break;
        case "region":
            
            break;
        case "AMAZON.CancelIntent":
            
            break;
        case "AMAZON.HelpIntent":
                alexa.say(speech: "You can ask me to login", reprompt: "So?")
            break;
        case "AMAZON.StopIntent":
            
            break;
        default:
                alexa.say(speech: "I didn't understand", reprompt: nil)
            break
        
        }
        
    default:
        alexa.say(speech: "I didn't understand", reprompt: nil)
        break
    }
    
    next()
}

router.get("/health") {
    request, response, next in
    response.status(.OK).send(json: JSON(["ok"]))
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8080, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()


