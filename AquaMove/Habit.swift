//
//  Habit.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class Habit : Codable, Identifiable {
    var id: String?
    //var id: String = UUID().uuidString
    var name : String
    var description : String
    var days : String
    var time : Date
    var isCompleted: Bool = false  // Lägg till denna rad
    
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, days, time, isCompleted
    }
    
    init(name: String, description: String, days: String, time: Date) {
        self.name = name
        self.description = description
        self.days = days
        self.time = time
        
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.days = try container.decode(String.self, forKey: .days)
        self.time = try container.decode(Date.self, forKey: .time)
        
    }
}

