//
//  LogoutIntent.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 15/7/17.
//
//

import Foundation
import SwiftyJSON

//TODO - Implement LoggerAPI
final class LogoutIntent: Intent {
    
    var slot: (id: Slot, region: Slot) = (Slot(), Slot())
    
    private func parseSlots() { }
    
    override func performRequest(_ alexa: AlexaRequest, completionHandler: @escaping (String, String) -> Void) {
        completionHandler(Speech.successful.rawValue, Reprompt.pardon.rawValue)
    }
}

extension LogoutIntent {
    enum Speech: String {
        case successful = "Goodbye"
        case fail = "I couldn't log you out"
    }
    
    enum Reprompt: String {
        case pardon = "I couldn't hear you clearly"
    }
}
