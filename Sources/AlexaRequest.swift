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
    
    init(_ json: JSON) {
        let intentJSON = json["request", "intent"]
        self.intent = Intent.registry(with: intentJSON)
    }
}
