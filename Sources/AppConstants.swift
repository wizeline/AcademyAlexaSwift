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
    static let scheme              = "https"
    static let endpoint            = "api.riotgames.com"
    static let loginByIDBasePath   = "/lol/summoner/v3/summoners/"
    static let currentGameBasePath = "/lol/spectator/v3/active-games/by-summoner/"
    static let apiKey              = "RGAPI-10a6d300-f09e-4629-88c2-a3f008fc72f8"
    static let recentMatchesBasePath = "/lol/match/v3/matchlists/by-account/"
    static let recentMatchesAppendingPath = "/recent"
}

class DatabasePropierties {
    static let host = "127.0.0.1"
    static let port = Int16(5984)
    static let name = "lolassistant"
    static let admin = "admin"
    static let password = "admin"
}

public enum Region: String {
    case northAmerica
    case europeWest
    case europeNordicAndEast
    case europeEast
    case brazil
    case turkey
    case russia
    case latinAmericaNorth = "la1"
    case latinAmericaSouth = "la2"
    case oceania
    case japan
    case korea
}
