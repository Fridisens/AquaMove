//
//  GoalsViewModel.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-26.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


class GoalsViewModel: ObservableObject {
    
    @Published var dailyGoals: [DailyGoal] = []
    @Published var goalsForSelectedDay: [DailyGoal]?
    
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
    
    func loadGoals(for date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)
        
        print("Loading goals for weekday: \(weekday)")
        
        // Filter dailyGoals to match weekdays
        goalsForSelectedDay = dailyGoals.filter { $0.day == weekday }
        
        print("Found \(goalsForSelectedDay?.count ?? 0) goals for \(weekday)")
    }
}
