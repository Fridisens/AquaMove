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
    var listener: ListenerRegistration?
    
    init() {
        
        loadHabits()
        
    }
    
    //    deinit {
    //           listenerRegistration?.remove()  // Glöm inte att ta bort lyssnaren när vyn inte längre används
    //        }
    //
    //    func setupHabitListener() {
    //        listenerRegistration = db.collection("habit").addSnapshotListener { [weak self] snapshot, error in
    //            guard let self = self else { return }
    //            if let error = error {
    //                print("Error getting documents: \(error)")
    //                return
    //            }
    //            guard let documents = snapshot?.documents else {
    //                print("No documents")
    //                return
    //            }
    //            DispatchQueue.main.async {
    //                self.habits = documents.compactMap { document in
    //                    try? document.data(as: Habit.self)
    //                }
    //            }
    //        }
    //    }
    
    
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
        db.collection("habit").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let querySnapshot = querySnapshot {
                DispatchQueue.main.async {
                    self.habits = querySnapshot.documents.compactMap { document in
                        let habit = try? document.data(as: Habit.self)
                        if let habit = habit {
                            habit.id = document.documentID  // Sätt till documentID efter dekodning
                            return habit
                        }
                        return nil
                    }
                    print("Total habits loaded: \(self.habits.count)")
                }
            }
        }
    }
    
    func stopListening() {
        listener?.remove()  // Anropa detta när du inte längre behöver lyssna på förändringar
    }
    
    func deleteHabit(at offsets: IndexSet) {
        for index in offsets {
            let habit = habits[index]
            if let documentId = habit.id {
                // Ta bort från Firestore
                db.collection("habit").document(documentId).delete { error in
                    if let error = error {
                        print("Error removing document: \(error)")
                    } else {
                        print("Habit successfully removed")
                    }
                }
                // Ta bort från lokal array
                DispatchQueue.main.async {
                    self.habits.remove(atOffsets: offsets)
                }
            }
        }
    }
        
        //    func loadHabits() {
        //        db.collection("habit").getDocuments { (querySnapshot, err) in
        //            if let err = err {
        //                print("Error getting documents: \(err)")
        //            } else {
        //                DispatchQueue.main.async {
        //                    self.habits = querySnapshot!.documents.compactMap { document in
        //                        let habit = try? document.data(as: Habit.self)
        //                        if let habit = habit {
        //                            print("Loaded habit: \(habit)")
        //                            habit.id = document.documentID
        //                            return habit
        //                        }
        //                        return nil
        //                    }
        //                    print("Total habits loaded: \(self.habits.count)")
        //                }
        //            }
        //        }
        //    }
        
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

