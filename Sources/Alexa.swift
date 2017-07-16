//
//  AlexaHandler.swift
//  SwiftEcho
//
//  Created by Oscar Mendoza Ochoa on 7/4/17.
//
//

import Foundation
import Kitura

struct Alexa {
    var response: RouterResponse
    
    init(response: RouterResponse) {
        self.response = response
    }

    func say(speech: String,
             reprompt: String? = nil,
             handler next: @escaping() -> Void) {
        let second = "\"reprompt\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"\(reprompt ?? "")\" } },"
        let jsonRawString = "{ \"version\": \"string\", \"sessionAttributes\": { \"string\": \"\" }, \"response\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"\(speech)\" }, \(second) \"shouldEndSession\": \"false\" } }"
        
        let responseJSON = convertToDictionary(from: jsonRawString) ?? convertToDictionary(from: errorRawString)!
        response.status(.OK).send(json: responseJSON)
        next()
    }
}
