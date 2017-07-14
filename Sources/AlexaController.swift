//
//  AlexaHandler.swift
//  SwiftEcho
//
//  Created by Oscar Mendoza Ochoa on 7/4/17.
//
//

import Foundation
import SwiftyJSON
import Kitura

public class AlexaController {
    
    var response: RouterResponse?
    
    func setup(_ kituraResponse: RouterResponse) {
        response = kituraResponse
    }
    
    // Outputs proper response to Alexa with simple speech response
    func say(speech: String, reprompt: String?) {
        let second = ( (reprompt != nil) ? "\"reprompt\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"\(reprompt!)\" } }," : "")
        let formedjson = "{ \"version\": \"string\", \"sessionAttributes\": { \"string\": \"\" }, \"response\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"\(speech)\" }, \(second) \"shouldEndSession\": \"false\" } }"
        
        response?.status(.OK).send(json: utils.convertToDictionary(from: formedjson)!)
    }
    
    
    func bye(speech: String) {
        let formedjson = "{ \"version\": \"string\", \"sessionAttributes\": { \"string\": \"\" }, \"response\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"\(speech)\" }, \"shouldEndSession\": \"true\" } }"
        
        response?.status(.OK).send(json: utils.convertToDictionary(from: formedjson)!)
    
    }

}
