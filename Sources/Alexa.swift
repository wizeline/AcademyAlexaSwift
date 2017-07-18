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
        
        let responseJSON = convertToDictionary(from: jsonRawString) ?? convertToDictionary(from: jsonRawString)!
        response.status(.OK).send(json: responseJSON)
        next()
    }
    
    
    /// Return closing session, alexa will stop waiting for input
    ///
    /// - Parameters:
    ///   - speech: message to output
    func exit(speech: String,
             handler next: @escaping() -> Void) {
        let jsonRawString = "{ \"version\": \"string\", \"sessionAttributes\": { \"string\": \"\" }, \"response\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"\(speech)\" }, \"shouldEndSession\": \"true\" } }"
        
        let responseJSON = convertToDictionary(from: jsonRawString) ?? convertToDictionary(from: jsonRawString)!
        response.status(.OK).send(json: responseJSON)
        next()
    }
}
