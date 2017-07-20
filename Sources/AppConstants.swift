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
    static let apiKey              = "RGAPI-ec832fc6-b496-4a5f-a029-7487d3cdcbbb"
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
    case northAmerica           = "na1"
    case europeWest             = "euw1"
    case europeNordicAndEast    = "eun1"
    case europeEast             = "eue1"
    case brazil                 = "br1"
    case turkey                 = "tr"
    case russia                 = "ru"
    case latinAmericaNorth      = "la1"
    case latinAmericaSouth      = "la2"
    case oceania                = "oc1"
    case japan                  = "jp1"
    case korea                  = "kr"
}
