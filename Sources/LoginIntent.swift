//
//  LoginIntent.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 14/7/17.
//
//

import Foundation
import SwiftyJSON
import LoggerAPI

//TODO - Implement LoggerAPI

//let usersHandler = UsersHandler()

final class LoginIntent: Intent {
    
    var slot: (id: Slot, region: Slot) = (Slot(), Slot())
    
    private func parseSlots() {
        guard !slots.isEmpty else { return }
        
        for (key, subJSON) : (String, JSON) in slots {
            
            switch key {
            case SlotKey.id.rawValue:
                slot.id = Slot(json: subJSON)
            case SlotKey.region.rawValue:
                slot.region = Slot(json: subJSON)
            default:
                break
            }
        }
    }
    
    override func performRequest(_ alexa: AlexaRequest, completionHandler: @escaping (String, String) -> Void) {
        parseSlots()
        //TODO manage missing values
        guard let _ = slot.id.name, let id = slot.id.value,
            let _ = slot.region.name, let _ = slot.region.value else { return }
        
        //TODO remove hard code region
        if let url = url(forScheme: API.scheme, endpoint: API.endpoint, basePath: API.loginByIDBasePath, region: "la2", id: id, apiKey: API.apiKey) {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard error == nil else { return }
                guard let response = response as? HTTPURLResponse, let data = data else { return }
                
                //TODO: Handle other cases
                if response.statusCode == 200 {
                    //TODO save user data into database
                    print("Logged in")
                    let foundUser = User(with: JSON(data: data), alexaId: alexa.alexaId)
                    usersHandler.find(alexa.alexaId, completition: { (user) in
                        if user != nil {
                            usersHandler.delete(alexa.alexaId, completition: { (deleted) in
                                if deleted == true {
                                    usersHandler.save(foundUser, completition: { (saved) in
                                        completionHandler(Speech.successful.rawValue + foundUser.name, Reprompt.pardon.rawValue)
                                    })
                                } else {
                                    //TODO
                                }
                            })
                        } else {
                            usersHandler.save(foundUser, completition: { (saved) in
                                completionHandler(Speech.successful.rawValue + foundUser.name, Reprompt.pardon.rawValue)
                            })
                        }
                    })
//                    completionHandler(Speech.successful.rawValue, Reprompt.pardon.rawValue)
                } else {
                    completionHandler(Speech.fail.rawValue, Reprompt.pardon.rawValue)
                    print("Failed log in")
                }
            }).resume()
        }
    }// 1190971 log in with ID one one nine zero nine seven one in latin america
}

extension LoginIntent {
    enum Speech: String {
        case successful = "Log in sucessfully. Good game "
        case fail = "I couldn't log you in"
    }
    
    enum Reprompt: String {
        case pardon = "I couldn't hear you clearly"
    }
}

extension LoginIntent {
    enum SlotKey: String {
        case id = "id"
        case region = "region"
    }
}
