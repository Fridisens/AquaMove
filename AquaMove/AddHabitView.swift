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
    
    @State private var selectedDay: String = "Måndag"
    @State private var selectedTime: Date = Date()
    
    @State private var selectedCategory = "Vatten"
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var goalText: String = ""
    
    
    
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
                
                Section(header: Text("Välj dag")) {
                    Picker("Dag", selection: $selectedDay) {
                        Text("Måndag").tag("Måndag")
                        Text("Tisdag").tag("Tisdag")
                        Text("Onsdag").tag("Onsdag")
                        Text("Torsdag").tag("Torsdag")
                        Text("Fredag").tag("Fredag")
                        Text("Lördag").tag("Lördag")
                        Text("Söndag").tag("Söndag")
                    }
                   
                    .pickerStyle(MenuPickerStyle()) // eller .pickerStyle(WheelPickerStyle())
                }
                
                Section(header: Text("Välj tid")) {
                    DatePicker("Tid", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Button("Lägg till vana") {
                    let newHabit = Habit(name: name, description: description, day: selectedDay, time: selectedTime)
                    habits.append(newHabit)
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
        let goalValue = Double(goalText) ?? 0  // Fortsätt att tolka målvärdet från text
        let newHabit: Habit
        if selectedCategory == "Vatten" {
            newHabit = WaterIntakeHabit(name: name, description: description, goal: goalValue, day: selectedDay, time: selectedTime)
        } else {
            newHabit = WellnessHabit(name: name, description: description, sessionLength: goalValue, day: selectedDay, time: selectedTime)
        }
        habits.append(newHabit)
    }
    
}
