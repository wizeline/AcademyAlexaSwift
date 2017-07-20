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
    
    override func performRequest(_ alexa: AlexaRequest, completionHandler: @escaping (String, String, Bool) -> Void) {
        usersHandler.delete(alexa.alexaId) { (result) in
            if(result) {
                completionHandler(Speech.successful.rawValue, Reprompt.pardon.rawValue, true)
            } else {
                completionHandler(Speech.fail.rawValue, Reprompt.pardon.rawValue, false)
            }
        }
    }
}

extension LogoutIntent {
    enum Speech: String {
        case successful = "Done, good bye."
        case fail = "You haven't started a session yet."
    }
    
    enum Reprompt: String {
        case pardon = "I couldn't hear you clearly"
    }
}
