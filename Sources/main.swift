import Kitura
import SwiftyJSON

// Create a new router
let router = Router()
registry()

router.all("/", middleware: BodyParser())

// Handle HTTP GET requests to /
router.get("/") {
    request, response, next in
    response.send("Kitura is ready to rock&roll.")
    next()
}

// Handle HTTP POST requests to /
router.post("/") {
    request, response, next in
    guard let parsedBody = request.body else {
        next()
        return
    }
    
    let alexa = AlexaController(response: response)
    var slots: Slot.Type?
    
    switch(parsedBody) {
    case .json(let json):
        let alexaReq = AlexaRequest(json)
        alexaReq.intent?.performRequest(completionHandler: { speech, prompt in
            alexa.say(speech: speech, reprompt: prompt)
        })
    default:
        alexa.say(speech: "I didn't understand", reprompt: nil)
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


