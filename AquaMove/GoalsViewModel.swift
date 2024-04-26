//
//  GoalsViewModel.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-26.
//

import SwiftUI

class GoalsViewModel: ObservableObject {
    
    @Published var dailyGoals: [DailyGoal] = [
            DailyGoal(day: "Måndag", goalsCompleted: true),
            DailyGoal(day: "Tisdag", goalsCompleted: false),
            DailyGoal(day: "Onsdag", goalsCompleted: true),
            DailyGoal(day: "Torsdag", goalsCompleted: true),
            DailyGoal(day: "Fredag", goalsCompleted: false),
            DailyGoal(day: "Lördag", goalsCompleted: true),
            DailyGoal(day: "Söndag", goalsCompleted: true),
        ]
    }
