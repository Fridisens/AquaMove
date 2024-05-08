//
//  dailyGoal.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-26.
//

import Foundation

struct DailyGoal: Identifiable, Codable {
    var id: UUID = UUID()
    var day: String
    var date: Date
    var goalsCompleted : Bool
}


