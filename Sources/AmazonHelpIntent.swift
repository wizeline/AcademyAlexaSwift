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
    
    override func performRequest(completionHandler: @escaping (String, String) -> Void) {
        completionHandler(Speech.successful.rawValue, Promt.so.rawValue)
    }
}

extension AmazonHelpIntent {
    enum Speech: String {
        case successful = "You can ask me to login"
    }
    
    enum RePromt: String {
        case pardon = "I couldn't hear you clearly"
        case so = "So"
    }
}
