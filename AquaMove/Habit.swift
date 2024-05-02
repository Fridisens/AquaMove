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
    var day : String
    var time : Date
    
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, day, time
    }
    
    init(name: String, description: String, day: String, time: Date) {
        self.name = name
        self.description = description
        self.day = day
        self.time = time
        
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.day = try container.decode(String.self, forKey: .day)
        self.time = try container.decode(Date.self, forKey: .time)
        
    }
}

