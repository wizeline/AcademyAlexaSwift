//
//  AlexaRequest.swift
//  SwiftEcho
//
//  Created by Oscar Mendoza Ochoa on 7/9/17.
//
//

import Foundation
import SwiftyJSON

public struct AlexaRequest {
    let intent: Intent?
    enum requestTypes {
        case LaunchRequest
        case SessionEndedRequest
        case IntentRequest
        case Unhandled
    }
    var requestType: requestTypes
    var alexaId: String
    
    init(_ json: JSON) {
        alexaId = json["session"]["user"]["userId"].stringValue
        
        switch json["request"]["type"].stringValue {
            case "LaunchRequest":
                requestType = .LaunchRequest
                break;
            case "IntentRequest":
                requestType = .IntentRequest
                break;
            case "SessionEndedRequest":
                requestType = .SessionEndedRequest
                break;
            default:
                requestType = .Unhandled
        }
        
        let intentJSON = json["request", "intent"]
        self.intent = Intent.registry(with: intentJSON)
    }
}
