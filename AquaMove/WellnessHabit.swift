//
//  WellnessHabit.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import Foundation

class WellnessHabit : Habit {
    var sessionLength: Double
    var unit: String = "minuter"
    
    init(name: String, description: String, sessionLength: Double) {
        self.sessionLength = sessionLength
        super.init(name: name, description: description, days: [])
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sessionLength = try container.decode(Double.self, forKey: .sessionLength)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sessionLength, forKey: .sessionLength)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case sessionLength
    }
}
