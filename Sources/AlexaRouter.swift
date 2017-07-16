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

final class AlexaRouter {
    let router = Router()
    
    init() {
        router.all("*", middleware: BodyParser())
        router.get("/", handler: handleServerTest)
        router.post("/", handler: handleVoiceCommand)
    }
}

//MARK: Routers
extension AlexaRouter {
    
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
        
        let alexa = Alexa(response: response)
        
        guard let json = request.json else {
            response.status(.badRequest)
            next()
            return
        }
        
        let alexaRequest = AlexaRequest(json)
        alexaRequest.intent?.performRequest(completionHandler: { speech, reprompt in
            alexa.say(speech: speech, reprompt: reprompt, handler: next)
        })
    }
}
