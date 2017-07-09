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

    var sessionId: String? = nil
    var userId: String? = nil
    var intent: String? = nil
    var timestamp: String? = nil
    var slots: String? = nil
    var requestType: String? = nil
    
    
    init(_ json: JSON) {
        
        sessionId = json["session"]["sessionId"].rawString()
        userId = json["session"]["user"]["userId"].rawString()
        intent = json["request"]["intent"]["name"].rawString()
        
        
        print(json)
    
    }
    
}
