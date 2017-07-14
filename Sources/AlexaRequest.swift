//
//  AlexaRequest.swift
//  SwiftEcho
//
//  Created by Oscar Mendoza Ochoa on 7/9/17.
//
//

import Foundation
import SwiftyJSON


public class AlexaRequest {

    let sessionId: String?
    let userId: String?
    let requestType: String?
    let timestamp: String?
    let intent: String?
    let slots: String?
    
    init(_ json: JSON) {
        sessionId = json["session"]["sessionId"].rawString()
        userId = json["session"]["user"]["userId"].rawString()
        requestType = json["request"]["type"].rawString()
        timestamp = json["request"]["timestamp"].rawString()
        intent = json["request"]["intent"]["name"].rawString()
        slots = json["request"]["intent"]["slot"].rawString()
    }
}
