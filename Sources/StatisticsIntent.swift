//
//  StatisticIntent.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 16/7/17.
//
//

import Foundation
import LoggerAPI
import SwiftyJSON

//TODO - Implement LoggerAPIf
final class StatisticsIntent: Intent {
    
    var slot = Slot()
    
    private(set) var ids: [Int] = []
    
    private func parseSlots() {
        guard !slots.isEmpty else { return }
        
        for (key, subJSON) : (String, JSON) in slots {
            
            switch key {
            case SlotKey.targetTeam.rawValue:
                slot = Slot(json: subJSON)
            default:
                break
            }
        }
    }
    
    override func performRequest(completionHandler: @escaping (String, String) -> Void) {
        parseSlots()
        guard let _ = slot.name, let _ = slot.value else { return }
        
        //TODO remove hard code region and ID. retrieve the current user id instead
        if let url = url(forScheme: API.scheme, endpoint: API.endpoint, basePath: API.currentGameBasePath, region: "euw1", id: "85739318", apiKey: API.apiKey) {
            
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard error == nil else { return }
                guard let response = response as? HTTPURLResponse, let data = data else { return }
                
                //TODO: Handle other cases
                if response.statusCode == 200 {
                    let match = Match(data: data)
                    self.ids = match.enemy
                    SessionManager.shared.requestPlayersStats(from: match.enemy, completion: { (result) in
                        var speech = ""
                        
                        for id in self.ids {
                            let laneStats = result[id]!
                            speech += "Player \(id) played in \(laneStats.lane.rawValue) \(laneStats.count) times in the last 20 matches. "
                        }
                        
                        completionHandler(speech, Reprompt.pardon.rawValue)
                    })
                }
            }).resume()
        }
    }
}

extension StatisticsIntent {
    enum Reprompt: String {
        case pardon = "I couldn't hear you clearly"
    }
}

extension StatisticsIntent {
    enum SlotKey: String {
        case targetTeam = "userTeam"
    }
}

extension StatisticsIntent {
    enum Team: String {
        case enemy = "enemy"
        case ally = "ally"
        case my = "my"
    }
}
