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
    var name : String
    var description : String
    var days : String
    var time : Date
    var isCompleted: Bool = false
    var completedDates: [Date] = []
    var currentStreak: Int = 0
    var longestStreak: Int = 0
    
    
    
    enum CodingKeys: String, CodingKey {
           case id, name, description, days, time, isCompleted, completedDates, currentStreak, longestStreak
       }
    
    init(name: String, description: String, days: String, time: Date, isCompleted: Bool = false, completedDates: [Date] = [], currentStreak: Int = 0, longestStreak: Int = 0) {
        self.id = UUID().uuidString
        self.name = name
            self.description = description
            self.days = days
            self.time = time
            self.isCompleted = isCompleted
            self.completedDates = completedDates
            self.currentStreak = currentStreak
            self.longestStreak = longestStreak
        }
    
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.description = try container.decode(String.self, forKey: .description)
            self.days = try container.decode(String.self, forKey: .days)
            self.time = try container.decode(Date.self, forKey: .time)
            self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
            let completedTimestamps = try container.decode([TimeInterval].self, forKey: .completedDates)
            self.completedDates = completedTimestamps.map(Date.init(timeIntervalSince1970:))
            self.currentStreak = try container.decode(Int.self, forKey: .currentStreak)
            self.longestStreak = try container.decode(Int.self, forKey: .longestStreak)
        }
    }

