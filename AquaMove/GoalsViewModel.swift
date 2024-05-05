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
    @Published var goalsForSelectedDay: [DailyGoal]?  // Lagrar vanor för valt datum
    
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
        dateFormatter.dateFormat = "EEEE"  // Svenska veckodagar
        let weekday = dateFormatter.string(from: date)
        
        print("Loading goals for weekday: \(weekday)")
        
        // Filtrera dailyGoals för att matcha veckodagen
        goalsForSelectedDay = dailyGoals.filter { $0.day == weekday }
        
        print("Found \(goalsForSelectedDay?.count ?? 0) goals for \(weekday)")
    }
}
