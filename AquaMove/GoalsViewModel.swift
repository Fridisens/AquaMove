//
//  GoalsViewModel.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-26.
//

import SwiftUI

class GoalsViewModel: ObservableObject {
    
    @Published var dailyGoals: [DailyGoal] = []
    
    init(){
        setupGoals()
    }
    
    private func setupGoals() {
        let calendar = Calendar.current
        let today = Date()
        let weekDays = ["Måndag", "Tisdag", "Onsdag", "Torsdag", "Fredag", "Lördag", "Söndag"]
        
        dailyGoals = weekDays.enumerated().map { index, day in
            let date = calendar.date(byAdding: .day, value: index, to: today)!
            return DailyGoal(day: day, date: date, goalsCompleted: false)
        }
    }
}

