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

    guard let parsedBody = request.body else {
        next()
        return
    }
    
    switch(parsedBody) {
    case .json(let jsonBody):
        
        let alexaReq = AlexaRequest(jsonBody)
        
        
        let respondToUser = alexa.say(speech: alexaReq.intent!)
        
        print(respondToUser ?? "Invalid: \(utils.fakeJSON)")
        
        response.status(.OK).send(json: respondToUser!)
        print(request)
        
        print(jsonBody)
        
    default:
        print("Got a something we cannot handle")
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


