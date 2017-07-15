//
//  LogoutIntent.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 15/7/17.
//
//

import Foundation
import SwiftyJSON

final class LogoutIntent: Intent {
    
    var slot: (id: Slot, region: Slot) = (Slot(), Slot())
    
    private func parseSlots() { }
    
    override func performRequest(completionHandler: @escaping (String, String) -> Void) {
        completionHandler(Speech.successful.rawValue, RePromt.pardon.rawValue)
    }
}

extension LogoutIntent {
    enum Speech: String {
        case successful = "Goodbye"
        case fail = "I couldn't log you out"
    }
    
    enum RePromt: String {
        case pardon = "I couldn't hear you clearly"
    }
}
