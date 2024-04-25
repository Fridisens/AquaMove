//
//  Habit.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import Foundation

class Habit : Identifiable, Codable {
    
    var id: String = UUID().uuidString
    var name : String
    var description : String
    var isCompleted: Bool = false
    
    init (name: String, description: String){
        self.name = name
        self.description = description
        
    }
    
    // Exempeldata
class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = [
        Habit(name: "Dricka vatten", description: "Drick 8 glas vatten dagligen"),
            Habit(name: "Morgonjogg", description: "Spring 30 minuter varje morgon")
        ]
    }
    
}
