//
//  AmazonHelpIntent.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 15/7/17.
//
//

import Foundation

final class AmazonHelpIntent: Intent {
    
    var slot: (id: Slot, region: Slot) = (Slot(), Slot())
    
    private func parseSlots() { }
    
    override func performRequest(_ alexa: AlexaRequest, completionHandler: @escaping (String, String?, Bool) -> Void) {
        completionHandler(Speech.successful.rawValue, Reprompt.pardon.rawValue, false)
    }
}

extension AmazonHelpIntent {
    enum Speech: String {
        case successful = "You can ask me to login with your ID and region"
    }
    
    enum Reprompt: String {
        case pardon = "I couldn't hear you clearly"
    }
}
