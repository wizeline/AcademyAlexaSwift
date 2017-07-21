//
//  MatchStatistic.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 18/7/17.
//
//

import Foundation
import SwiftyJSON

struct MatchStatistic {
    let lane: Lane
    let gameId: Int64
    let championId: Int
    let platformId: String
    let role: Role
    let season: Int
    
    init(json: JSON) {
        self.lane = Lane(string: json["lane"].stringValue)
        self.gameId = json["gameId"].int64Value
        self.championId = json["champion"].intValue
        self.platformId = json["platformId"].stringValue
        self.role = Role(string: json["role"].stringValue)
        self.season = json["season"].intValue
    }
}

extension MatchStatistic {
    enum Lane: String {
        case mid = "MID"
        case top = "TOP"
        case bottom = "BOTTOM"
        case jungle = "JUNGLE"
        case none = "NONE"
        
        init(string: String) {
            switch string.uppercased() {
            case "MID":
                self = .mid
            case "TOP":
                self = .top
            case "BOTTOM":
                self = .bottom
            case "JUNGLE":
                self = .jungle
            case "NONE":
                self = .none
            default:
                self = .none
            }
        }
    }
    
    enum Role: String {
        case solo = "SOLO"
        case duo = "DUO"
        case none = "NONE"
        
        init(string: String) {
            switch string.uppercased() {
            case "SOLO":
                self = .solo
            case "DUO":
                self = .duo
            case "NONE":
                self = .none
            default:
                self = .none
            }
        }
    }
}
