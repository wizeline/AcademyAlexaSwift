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
    
    let fakeUser = "{ \"name\": \"HienAFK\", \"summonerLevel\": \"30\", \"accountId\": \"231123\", \"revisionDate\": \"1231313\", \"region\": \"LAN\" }"
}
//TODO - Add description
func convertToDictionary(from text: String) -> EasyJSON? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? EasyJSON
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

//TODO - Add description
func registry() {
    Intent.registry["login"] = LoginIntent.self
    Intent.registry["logout"] = LogoutIntent.self
    Intent.registry["statistics"] = StatisticsIntent.self
    Intent.registry["AMAZON.HelpIntent"] = AmazonHelpIntent.self
}

//TODO - Add description
func url(forScheme scheme: String, endpoint: String, basePath: String, region: String, id: String, apiKey: String) -> URL? {
    var baseURL = URLComponents()
    baseURL.scheme = scheme
    baseURL.host =  region + "." + endpoint
    baseURL.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    return baseURL.url?.appendingPathComponent(basePath).appendingPathComponent(id, isDirectory: false)
}

func url(forScheme scheme: String, endpoint: String, basePath: String, region: String, id: String, apiKey: String, appendingPath path: String) -> URL? {
    var baseURL = URLComponents()
    baseURL.scheme = scheme
    baseURL.host =  region + "." + endpoint
    baseURL.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    return baseURL.url?.appendingPathComponent(basePath).appendingPathComponent(id).appendingPathComponent(path, isDirectory: false)
}
