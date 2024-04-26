//
//  HabitsViewModel.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import Foundation
import Firebase

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    private var db = Firestore.firestore()
    
    
    func addHabit(habit: Habit) {
        do {
            let ref = try db.collection("habits").addDocument(from: habit)
            ref.getDocument { (document, error) in
                if let document = document, document.exists {
                    print("Document data: \(String(describing: document.data()))")
                } else {
                    print("Document does not exist")
                }
            }
            print("Habit added with ID: \(ref.documentID)")
        } catch let error {
            print("Error saving habit to Firestore: \(error.localizedDescription)")
        }
    }
    
    func loadHabits() {
        db.collection("habits").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                self.habits = querySnapshot!.documents.compactMap { document in
                    var habit = try? document.data(as: Habit.self)
                    habit?.id = document.documentID
                    return habit
                }
            }
        }
    }
    
}
