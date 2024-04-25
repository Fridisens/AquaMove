//
//  HabitsViewModel.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import Foundation

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    func addHabit(habit: Habit) {
        habits.append(habit)
    }
    
    //Add more methods here to handle habits - remove or change
}
