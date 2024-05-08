//
//  AquaMoveApp.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-24.
//

import SwiftUI
import UIKit
import FirebaseCore
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
        
        
    }
}

@main
struct AquaMoveApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModelHabit = HabitsViewModel()
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(viewModelHabit)
        }
    }
}

