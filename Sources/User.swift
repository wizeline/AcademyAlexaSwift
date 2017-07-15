//
//  User.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 14/7/17.
//
//

import Foundation
import SwiftyJSON

struct User {
    let profileIconId: Int
    let name: String
    let summonerLevel: Int
    let accountId: Int64
    let id: Int64
    let revisionDate: Int64
    
    init(with json: JSON) {
        profileIconId = json["profileIconId"].intValue
        name = json["name"].stringValue
        summonerLevel = json["name"].intValue
        accountId = json["accountId"].int64Value
        id = json["id"].int64Value
        revisionDate = json["revisionDate"].int64Value
    }
}
