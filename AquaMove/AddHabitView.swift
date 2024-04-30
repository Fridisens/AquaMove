//
//  AddHabitView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var habits: [Habit]
    
    @State private var selectedCategory = "Vatten"
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var goalText: String = ""
    
    @State private var days: [DaySelection] = [
        DaySelection(name: "Måndag", isSelected: false),
        DaySelection(name: "Tisdag", isSelected: false),
        DaySelection(name: "Onsdag", isSelected: false),
        DaySelection(name: "Torsdag", isSelected: false),
        DaySelection(name: "Fredag", isSelected: false),
        DaySelection(name: "Lördag", isSelected: false),
        DaySelection(name: "Söndag", isSelected: false)
    ]
    
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Kategori")) {
                    Picker("Välj en kategori", selection: $selectedCategory) {
                        Text("Vatten").tag("Vatten")
                        Text("Träning").tag("Träning")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Detaljer")) {
                    TextField("Namn på vanan", text: $name)
                    TextField("Beskrivning", text: $description)
                    if selectedCategory == "Vatten" {
                        TextField("Liter", text: $goalText)
                            .keyboardType(.decimalPad)
                    } else {
                        TextField("Minuter", text: $goalText)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Välj dagar")) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach($days) { $day in
                            DayButton(day: $day)
                        }
                    }
                }
                
                
                
                Button("Lägg till vana") {
                    addHabit()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Ny Vana")
            .navigationBarItems(trailing: Button("Stäng") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func addHabit() {
        let goalValue = Double(goalText) ?? 0
        let selectedDays = days.filter { $0.isSelected }.map { $0.name }
        let newHabit: Habit
        if selectedCategory == "Vatten" {
            newHabit = WaterIntakeHabit(name: name, description: description, goal: goalValue)
        } else {
            newHabit = WellnessHabit(name: name, description: description, sessionLength: goalValue)
        }
        habits.append(newHabit)
    }
}
