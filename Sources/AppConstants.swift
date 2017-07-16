//
//  AppConstants.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 14/7/17.
//
//

import Foundation

typealias EasyJSON = [String: Any]

///Default error message
//Alexa will say this if its controller falls to convert to dictionary from raw string
let errorRawString = "{ \"version\": \"string\", \"sessionAttributes\": { \"string\": \"\" }, \"response\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"There's something wrong with that. Can you try again?\" }, \"reprompt\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"I couldn\'t hear you clearly\" } }, \"shouldEndSession\": \"false\" } }"

class API {
    static let scheme = "https"
    static let endpoint = "api.riotgames.com"
    static let loginByIDBasePath = "/lol/summoner/v3/summoners/"
    static let apiKey = "RGAPI-b9363015-3df0-4cc6-9fda-f6f4893044f6"
}




