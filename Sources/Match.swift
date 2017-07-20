//
//  Match.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 16/7/17.
//
//

import Foundation
import SwiftyJSON

struct Match {
    let gameID: Int?
    let gameMode: String
    let gameType: String
    let participants: [Participant]
    let platformID: String
    
    var allies: [Int] {
        get {
            return participants.prefix(upTo: participants.count / 2).flatMap { $0.summonerId }
        }
    }
    
    var enemy: [Int] {
        get {
            return participants.suffix(from: participants.count / 2).flatMap { $0.summonerId }
        }
    }
    
    init(data: Data) {
        let json = JSON(data: data)
        self.init(json: json)
    }
    
    init(json: JSON) {
        self.gameID = json["gameId"].int
        self.gameMode = json["gameMode"].stringValue
        self.gameType = json["gameType"].stringValue
        self.participants = json["participants"].arrayValue.map { Participant(json: $0) }
        self.platformID = json["platformID"].stringValue
    }
}

