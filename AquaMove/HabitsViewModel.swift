//
//  HabitsViewModel.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import Foundation
import Firebase
import FirebaseFirestore

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = []
  
    
    private var db = Firestore.firestore()
    
    init() {
        loadHabits()
    }

    //    func addHabit(habit: Habit) {
    //        let newHabit = Habit(name: name, description: description, day: selectedDay, time: selectedTime)
    //        habits.append(newHabit)
    //        do {
    //            try db.collection("habit").document(newHabit.id ?? UUID().uuidString).setData(from: newHabit) { error in
    //                if let error = error {
    //                    print("Error adding document: \(error.localizedDescription)")
    //                } else {
    //                    print("Document successfully added.")
    //                }
    //            }
    //        } catch let error {
    //            print("Error writing habit to Firestore: \(error.localizedDescription)")
    //        }
    //
    //    }
    
    
    
    func loadHabits() {
        db.collection("habit").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                DispatchQueue.main.async { 
                    self.habits = querySnapshot!.documents.compactMap { document in
                        let habit = try? document.data(as: Habit.self)
                        habit?.id = document.documentID  // Tilldela Firestore dokument-ID
                        return habit
                    }
                }
            }
        }
    }
}
