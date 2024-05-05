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
    
    func updateHabitCompletion(_ habit: Habit) {
        guard let documentId = habit.id else { return }
        db.collection("habit").document(documentId).updateData([
            "isCompleted": habit.isCompleted
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Habit completion updated successfully.")
            }
        }
    }

    
    func loadHabits() {
        db.collection("habit").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                DispatchQueue.main.async {
                    self.habits = querySnapshot!.documents.compactMap { document in
                        let habit = try? document.data(as: Habit.self)
                        habit?.id = document.documentID  // Tilldela Firestore dokument-ID
                        print("Loaded isCompleted: \(habit?.isCompleted ?? false)")

                        return habit
                    }
                }
            }
        }
    }
    
}
