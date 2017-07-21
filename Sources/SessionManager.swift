//
//  SessionManager.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 16/7/17.
//
//

import Foundation
import Dispatch

internal typealias Lane = MatchStatistic.Lane
internal typealias Role = MatchStatistic.Role
typealias LaneStats = (lane: Lane, count: Int)

final class SessionManager {
    static var shared = SessionManager()
    
    private init() { }
    
    let queue = DispatchQueue(label: "com.wizeline.alexa")
    
    var userStats: [Int: LaneStats] = [:]
    
    var tasks: [Int: URLSessionTask] = [:]
    
    var platformID = ""
    
    func requestPlayersStats(from summonerIdList: [Int], region: String, completion: @escaping(_ userStats: [Int: LaneStats]) -> Void) {
        platformID = region
        for id in summonerIdList {
            if let url = url(forScheme: API.scheme, endpoint: API.endpoint, basePath: API.loginByIDBasePath, region: platformID, id: "\(id)", apiKey: API.apiKey) {
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
                let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
                    guard error == nil else { return }
                    guard let response = response as? HTTPURLResponse, let data = data else { return }
                    guard let `self` = self else { return }
                    
                    //TODO: Handle other cases
                    if response.statusCode == 200 {
                        let user = User(data: data)
                        self.requestRecentMatches(user: user, completion: completion)
                    }
                })
                tasks[id.hashValue] = task
                task.resume()
            }
        }
    }
    
    func requestRecentMatches(user: User, completion: @escaping(_ userStats: [Int: LaneStats]) -> Void) {
        if let url = url(forScheme: API.scheme, endpoint: API.endpoint, basePath: API.recentMatchesBasePath, region: platformID, id: "\(user.accountId)", apiKey: API.apiKey, appendingPath: API.recentMatchesAppendingPath) {
            
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
                guard error == nil else { return }
                guard let response = response as? HTTPURLResponse, let data = data else {
                    return
                }
                guard let `self` = self else { return }
                
                //TODO: Handle other cases
                if response.statusCode == 200 {
                    let recentMatches = RecentResult(data: data)
                    let mostPlayedLane = recentMatches.mostPlayedLane()
                    
                    self.queue.sync {
                        self.userStats[user.summonerID] = mostPlayedLane
                        self.tasks.removeValue(forKey: user.summonerID.hashValue)
                    }
                }
                
                if self.tasks.isEmpty {
                    completion(self.userStats)
                }
            })
            task.resume()
        }
    }
}

extension SessionManager {
    //This function is just for testing.
    func testWhoIsPlaying(from summonerIdList: [Int]) {
        for id in summonerIdList {
            if let url = url(forScheme: API.scheme, endpoint: API.endpoint, basePath: API.currentGameBasePath, region: platformID, id: "\(id)", apiKey: API.apiKey) {
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
                URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
                    guard error == nil else { return }
                    guard let response = response as? HTTPURLResponse, let _ = data else { return }
                    guard let `self` = self else { return }
                    
                    //TODO: Handle other cases
                    if response.statusCode == 200 {
                        self.queue.sync {

                        }
                    } else {
                        print("404")
                    }
                }).resume()
            }
        }
    }
}

