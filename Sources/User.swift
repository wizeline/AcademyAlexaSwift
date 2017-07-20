//
//  User.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 14/7/17.
//
//

import Foundation
import SwiftyJSON

//TODO - We don't need Hashable for now. But we might in the future
public struct User: Hashable {
    let summonerID: Int
    let name: String
    let summonerLevel: Int
    let accountId: Int64
    let revisionDate: Int64
    let region: String
    let alexaId: String
    
    public var hashValue: Int {
        return Int(self.accountId)
    }
    
    init(data: Data) {
        let json = JSON(data: data)
        self.init(with: json, alexaId: "1")
    }
    
    init(with json: JSON, alexaId alexa: String) {
        alexaId       = alexa
        summonerID    = json["id"].intValue
        name          = json["name"].stringValue
        summonerLevel = json["summonerLevel"].intValue
        accountId     = json["accountId"].int64Value
        revisionDate  = json["revisionDate"].int64Value
        region        = json["platformId"].stringValue
    }
}

public func ==(lhs: User, rhs: User) -> Bool {
    if  lhs.name == rhs.name,
        lhs.summonerLevel == rhs.summonerLevel,
        lhs.summonerID == rhs.summonerID,
        lhs.accountId == rhs.accountId,
        lhs.revisionDate == rhs.revisionDate,
        lhs.region == rhs.region {
        return true
    }
    
    return false
}


