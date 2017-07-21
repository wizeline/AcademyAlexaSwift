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
    
    override func performRequest(_ alexa: AlexaRequest, completionHandler: @escaping (String, String?, Bool) -> Void) {
        parseSlots()
        guard let _ = slot.id.name, let id = slot.id.value,
        let _ = slot.region.name, let region = slot.region.value else {  completionHandler(Speech.fail.rawValue, Reprompt.pardon.rawValue, false);  return }
        
        
        let regionShortCode = regionCode(region)
        if (regionShortCode == nil) {
            completionHandler(Speech.fail.rawValue, Reprompt.pardon.rawValue, false)
            return
        }

        

        if let url = url(forScheme: API.scheme, endpoint: API.endpoint, basePath: API.loginByIDBasePath, region: regionShortCode!, id: id, apiKey: API.apiKey) {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard error == nil else { return }
                guard let response = response as? HTTPURLResponse, let data = data else { return }
                
                //TODO: Handle other cases
                if response.statusCode == 200 {
                    //TODO save user data into database
                    print("Logged in")
                    var foundUser = User(with: JSON(data: data), alexaId: alexa.alexaId)
                    foundUser.setRegion(regionShortCode!)
                    usersHandler.find(alexa.alexaId, completition: { (user) in
                        if user != nil {
                            usersHandler.delete(alexa.alexaId, completition: { (deleted) in
                                if deleted == true {
                                    usersHandler.save(foundUser, completition: { (saved) in
                                        completionHandler(Speech.successful.rawValue + foundUser.name, Reprompt.pardon.rawValue, false)
                                    })
                                } else {
                                    //TODO
                                }
                            })
                        } else {
                            usersHandler.save(foundUser, completition: { (saved) in
                                completionHandler(Speech.successful.rawValue + foundUser.name, Reprompt.pardon.rawValue, false)
                            })
                        }
                    })

                } else {
                    completionHandler(Speech.fail.rawValue, Reprompt.pardon.rawValue, false)
                    print("Failed log in")
                }
            }).resume()
        }
    }
}

extension LoginIntent {
    enum Speech: String {
        case successful = "Log in sucessfully. What can I do for you "
        case fail = "Sorry, I couldn't find your account. Try again."
    }
    
    enum Reprompt: String {
        case pardon = "Please say your ID and region"
    }
}

extension LoginIntent {
    enum SlotKey: String {
        case id = "id"
        case region = "region"
    }
}
