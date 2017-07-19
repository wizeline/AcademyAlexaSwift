//
//  RecentResult.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 19/7/17.
//
//

import Foundation
import SwiftyJSON

struct RecentResult {
    typealias Lane = MatchStatistic.Lane
    typealias Role = MatchStatistic.Role
    
    let totalGames: Int
    let matchList: [MatchStatistic]
    
    var lanes: [Lane] {
        get {
            return matchList.flatMap { $0.lane }
        }
    }
    
    var roles: [Role] {
        get {
            return matchList.flatMap { $0.role }
        }
    }
    
    init(data: Data) {
        let json = JSON(data: data)
        self.init(json: json)
    }
    
    init(json: JSON) {
        self.totalGames = json["totalGames"].intValue
        self.matchList = json["matches"].arrayValue.map { MatchStatistic(json: $0) }
    }
    
    private func categorizeLanes() -> [Lane: Int] {
        var resultDict = [
            Lane.mid: 0,
            Lane.top: 0,
            Lane.bottom: 0,
            Lane.jungle: 0,
            Lane.none: 0,
        ]
        
        let _ = lanes.reduce(resultDict) { (_, lane) in
            if resultDict[lane] != nil {
                resultDict[lane]! += 1
            }
            return resultDict
        }
        
        return resultDict
    }
    
    
    //TODO - Make it generic
    func mostPlayedLane() -> LaneStats {
        let dict = categorizeLanes()
        
        var maxLane: Lane = .none
        var maxCount = 0
        for (lane, count) in dict {
            if count > maxCount {
                maxCount = count
                maxLane = lane
            }
        }
        
        return (maxLane, maxCount)
    }
}
