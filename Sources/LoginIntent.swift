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
    
    override func performRequest(completionHandler: @escaping (String, String) -> Void) {
        parseSlots()
        guard let _ = slot.id.name, let id = slot.id.value,
            let _ = slot.region.name, let _ = slot.region.value else { return }
        
        //TODO remove hard code region
        if let url = url(forScheme: API.scheme, endpoint: API.endpoint, basePath: API.loginByIDBasePath, region: "euw1", id: id, apiKey: API.apiKey) {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard error == nil else { return }
                guard let response = response as? HTTPURLResponse, let _ = data else { return }
                
                //TODO: Handle other cases
                if response.statusCode == 200 {
                    //TODO save user data into database
                    completionHandler(Speech.successful.rawValue, Reprompt.pardon.rawValue)
                }
            }).resume()
        }
    }
}

extension LoginIntent {
    enum Speech: String {
        case successful = "Log in sucessfully. Good game well-played"
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
