//
//  LoginIntent.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 14/7/17.
//
//

import Foundation
import SwiftyJSON

final class LoginIntent: Intent {
    
    var slot: (id: Slot, region: Slot) = (Slot(), Slot())
    
    override func parseSlots() {
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
    
    override func performRequest() {
        <#code#>
    }
}

extension LoginIntent {
    enum SlotKey: String {
        case id = "id"
        case region = "region"
    }
}
