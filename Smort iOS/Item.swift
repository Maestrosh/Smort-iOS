//
//  Item.swift
//  Smort iOS
//
//  Created by Mehdi Shakibapour on 7/18/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
