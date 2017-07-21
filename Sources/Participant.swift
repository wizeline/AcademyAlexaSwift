//
//  Paticipant.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 16/7/17.
//
//

import Foundation
import SwiftyJSON

struct Participant {
    let teamId: Int?
    let spell1Id: Int?
    let spell2Id: Int?
    let championId: Int?
    let profileIconId: Int?
    let summonerName: String?
    let isBot: Bool?
    let summonerId: Int?
    
    init(json: JSON) {
        self.teamId = json["teamId"].int
        self.spell1Id = json["spell1Id"].int
        self.spell2Id = json["spell2Id"].int
        self.championId = json["championId"].int
        self.profileIconId = json["profileIconId"].int
        self.summonerName = json["summonerName"].string
        self.isBot = json["bot"].bool
        self.summonerId = json["summonerId"].int
    }
}
