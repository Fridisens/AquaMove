//
//  GoalsViewModel.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-26.
//

import SwiftUI

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
    
    func loadGoals() {
           // Här skulle du ladda alla tillgängliga vanor från din databas eller annan datakälla
       }

       func loadGoals(for date: Date) {
           // Filtrera dailyGoals för att matcha valt datum
           goalsForSelectedDay = dailyGoals.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
       }
   }


