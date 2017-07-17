//
//  AppConstants.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 14/7/17.
//
//

import Foundation

typealias EasyJSON = [String: Any]

class API {
    static let scheme = "https"
    static let endpoint = "api.riotgames.com"
    static let loginByIDBasePath = "/lol/summoner/v3/summoners/"
    static let apiKey = "RGAPI-d6e14709-ca44-43f8-aade-235658bc1f11"
}

class DatabasePropierties {
    static let host = "127.0.0.1"
    static let port = Int16(5984)
    static let name = "lolassistant"
    static let admin = "admin"
    static let password = "admin"
}
