//
//  Utils.swift
//  SwiftEcho
//
//  Created by Oscar Mendoza Ochoa on 7/7/17.
//
//

import Foundation
import SwiftyJSON

public class Utils {

    let fakeJSON = "{ \"version\": \"string\", \"sessionAttributes\": { \"string\": \"\" }, \"response\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"Hello summoner. What do you want to do? \" }, \"reprompt\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"Say HELP if you want to listen options.\" } }, \"shouldEndSession\": \"false\" } }"

    
    
}

func convertToDictionary(from text: String) -> Json? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? Json
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

func registry() {
    Intent.registry["login"] = LoginIntent.self
}
