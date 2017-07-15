//
//  Slot.swift
//  SwiftEcho
//
//  Created by Hien Quang Tran on 14/7/17.
//
//

import Foundation
import SwiftyJSON

struct Slot {
    let name: String?
    let value: String?
    
    init(json: JSON) {
        self.name = json["name"].rawString()
        self.value = json["value"].rawString()
    }
    
    init() {
        self.name = nil
        self.value = nil
    }
}
