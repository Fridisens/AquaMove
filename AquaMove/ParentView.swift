//
//  ParentView.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-05-06.
//

import SwiftUI

struct ParentView: View {
    @StateObject var viewModelHabit = HabitsViewModel()

    var body: some View {
        TabView {
            GoalsView(viewModelHabit: viewModelHabit)
            HabitsView(viewModel: viewModelHabit)
        }
    }
}
