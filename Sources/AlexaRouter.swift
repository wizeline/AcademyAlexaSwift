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
import SwiftyJSON

let usersHandler = UsersHandler()

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
        let alexa = Alexa(response: response)

        guard let json = request.json else {
            response.status(.badRequest)
            next()
            return
        }
        
        let alexaRequest = AlexaRequest(json)
        
        switch alexaRequest.requestType {
        case .IntentRequest:
            alexaRequest.intent?.performRequest(alexaRequest, completionHandler: { speech, reprompt, shouldEnd in
                if(shouldEnd == false) {
                    alexa.say(speech: speech, reprompt: reprompt, handler: next)
                } else {
                    alexa.exit(speech: speech, handler: next)
                }
            })
                break;
        case .LaunchRequest:
            usersHandler.find(alexaRequest.alexaId, completition: { (user) in
                if let summoner = user {
                    alexa.say(speech: "Hello \(summoner.name), what do you want to do?", handler: next)
                } else {
                    alexa.say(speech: "Hello summoner, please log in to continue", reprompt: "I need your account ID and your region", handler: next)
                }
            })
                break;
        default:
            alexa.exit(speech: "There was a internal problem", handler: next)
            break;
        }
        
//        alexa.say(speech: "Welcome to League assistant. What can I do for you?", reprompt: "I didn't hear you.", handler: next)
    }
}
