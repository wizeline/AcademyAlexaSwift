//
//  Alexa.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 16/7/17.
//
//

import Foundation
import Kitura
import LoggerAPI

class Alexa {
    let router = Router()
    
    init() {
        router.all("/", middleware: BodyParser())
        router.get("/", handler: handleServerTest)
        router.post("/", handler: handleVoiceCommand)
    }
}

extension Alexa {
    
    func handleServerTest(request: RouterRequest,
                          response: RouterResponse,
                           next: @escaping() -> Void)  throws {
        Log.info("Alexa for the rescue")
        response.status(.OK).send("Alexa is ready to rock&roll.")
        next()
    }
    
    func handleVoiceCommand(request: RouterRequest,
                            response: RouterResponse,
                            next: @escaping() -> Void) throws {
        Log.info("Alexa has received you command")
        guard let parsedBody = request.body else {
            next()
            return
        }
        
        let alexaController = AlexaController(response: response)
        
        switch(parsedBody) {
        case .json(let json):
            let alexaReq = AlexaRequest(json)
            alexaReq.intent?.performRequest(completionHandler: { speech, prompt in
                alexaController.say(speech: speech, reprompt: prompt)
            })
        default:
            alexaController.say(speech: "I didn't understand", reprompt: nil)
        }
        
        next()
    }
}
