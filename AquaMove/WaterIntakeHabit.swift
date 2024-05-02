//
//  WaterIntakeHabit.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import Foundation
import SwiftUI

class WaterIntakeHabit : Habit {
    var goal: Double
    var unit: String = "liter"
    
    
    init(name: String, description: String, goal: Double, days: String, time: Date) {
        self.goal = goal
      
        
        super.init(name: name, description: description, days: days, time: time)
    }

    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            goal = try container.decode(Double.self, forKey: .goal)
            try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(goal, forKey: .goal)
            try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case goal
    }
}
