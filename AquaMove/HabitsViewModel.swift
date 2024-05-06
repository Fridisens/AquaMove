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
    
    func updateHabitCompletion(_ habit: Habit, on date: Date) {
        guard let documentId = habit.id else { return }
        let alreadyCompleted = habit.completedDates.contains { Calendar.current.isDate($0, inSameDayAs: date) }

        if alreadyCompleted {
            habit.completedDates.removeAll { Calendar.current.isDate($0, inSameDayAs: date) }
            habit.currentStreak = max(0, habit.currentStreak - 1)
        } else {
            habit.completedDates.append(date)
            updateStreaks(for: habit)
        }

        db.collection("habit").document(documentId).updateData([
            "completedDates": habit.completedDates.map { $0.timeIntervalSince1970 },
            "currentStreak": habit.currentStreak,
            "longestStreak": habit.longestStreak
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
                        if let habit = habit {
                            print("Loaded habit: \(habit)")
                            habit.id = document.documentID
                            return habit
                        }
                        return nil
                    }
                    print("Total habits loaded: \(self.habits.count)")
                }
            }
        }
    }
    
    func updateStreaks(for habit: Habit) {
        let sortedDates = habit.completedDates.sorted()
        var currentStreak = 0
        var longestStreak = 0
        var lastDate: Date?

        for date in sortedDates {
            if let lastDate = lastDate, Calendar.current.isDate(date, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: lastDate)!) {
                currentStreak += 1
            } else {
                currentStreak = 1
            }
            longestStreak = max(longestStreak, currentStreak)
            lastDate = date
        }

        habit.currentStreak = currentStreak
        habit.longestStreak = longestStreak
    }
}
