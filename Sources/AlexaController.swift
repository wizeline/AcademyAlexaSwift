//
//  AlexaHandler.swift
//  SwiftEcho
//
//  Created by Oscar Mendoza Ochoa on 7/4/17.
//
//

import Foundation
import SwiftyJSON

public class AlexaController {


    // Outputs proper response to Alexa with simple speech response
    func say(speech: String) ->  [String : Any]? {
        let fakeJSON = "{ \"version\": \"string\", \"sessionAttributes\": { \"string\": \"\" }, \"response\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"\(speech)\" }, \"reprompt\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"Say HELP if you want to listen options.\" } }, \"shouldEndSession\": \"false\" } }"
    
        return utils.convertToDictionary(text: fakeJSON)
    }

}
