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
    
    override func performRequest(_ alexa: AlexaRequest, completionHandler: @escaping (String, String?, Bool) -> Void) {
        parseSlots()
        guard let _ = slot.name, let _ = slot.value else { return }
        
        usersHandler.find(alexa.alexaId) { (responseData) in
            if let user = responseData {
                self.performRequestActiveGames(alexa, user, completionHandler: completionHandler)
            } else {
                completionHandler("Please log in with your summoner Id and region.", "I didn't hear you.", false)
            }
        }
        
    }


    func performRequestActiveGames(_ alexa: AlexaRequest, _ user: User, completionHandler: @escaping (String, String?, Bool) -> Void) {
        //TODO remove hard code region and ID. retrieve the current user id instead
        if let url = url(forScheme: API.scheme, endpoint: API.endpoint, basePath: API.currentGameBasePath, region: user.platformID, id: "\(user.summonerID)", apiKey: API.apiKey) {
            
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard error == nil else {
                    print("Error: \(error.debugDescription)")
                    completionHandler("There was an error calling the LoL api", nil, true)
                    return
                }
                guard let response = response as? HTTPURLResponse, let data = data else {
                    print("Error: \(error.debugDescription)")
                    completionHandler("There was an error calling the LoL api", nil, true)
                    return
                }
                
                //TODO: Handle other cases
                if response.statusCode == 200 {
                    let match = Match(data: data)
                    self.ids = match.enemy
                    SessionManager.shared.requestPlayersStats(from: match.enemy, region: user.platformID, completion: { (result) in
                        var speech = ""
                        
                        for id in self.ids {
                            let laneStats = result[id]!
                            let defaultChampion = "Player "
                            speech += "\(championName(whatChampion(match, id)) ?? defaultChampion) played in \(laneStats.lane.rawValue) \(laneStats.count) times in the last 20 matches. "
                        }
                        
                        completionHandler(speech, nil, false)
                    })
                } else if response.statusCode == 404 {
                    completionHandler("Seems that there is not current game", nil, false)
                    print("Error: \(response.statusCode)")
                } else {
                    completionHandler("Seems that there is not current game", nil, false)
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
