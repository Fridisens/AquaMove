//
//  DaySelection.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-29.
//

import Foundation

struct DaySelection: Identifiable {
    let id = UUID()
    let name: String
    var isSelected: Bool = false
}
