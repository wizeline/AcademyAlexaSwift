//
//  Intent.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 14/7/17.
//
//

import Foundation
import SwiftyJSON

class Intent {
    static var registry: [String: Intent.Type] = [:]
    
    var slots: [String: JSON]
    
    static func registry(with json: JSON) -> Intent? {
        guard let intentName = json["name"].rawString(),
            let Entry = registry[intentName] else {
            return nil
        }
        
        return Entry.init(with: json)
    }
    
    required init(with json: JSON) {
        self.slots = json["slots"].dictionaryValue
    }
    
    func parseSlots() { }
    
    func performRequest() { }
}
