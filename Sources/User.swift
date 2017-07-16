//
//  User.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 14/7/17.
//
//

import Foundation
import SwiftyJSON

public struct User {
    let name: String
    let summonerLevel: Int
    let accountId: Int64
    let revisionDate: Int64
    let region: String
    let alexaId: String
    
    init(with json: JSON, alexaId alexa: String) {
        alexaId =               alexa
        name =                  json["name"].stringValue
        summonerLevel =         json["summonerLevel"].intValue
        accountId =             json["accountId"].int64Value
        revisionDate =          json["revisionDate"].int64Value
        region =                json["region"].stringValue
    }
}
