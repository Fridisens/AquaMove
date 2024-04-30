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
        print("Firebase configured successfully.")
        
        configureTabBar()
        return true
    }
    
    func configureTabBar() {
        UITabBar.appearance().barTintColor = UIColor(red: 93/255, green: 197/255, blue: 182/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }
}

@main
struct AquaMoveApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
    
    func configureTabBar() {
        UITabBar.appearance().barTintColor = UIColor(red: 93/255, green: 197/255, blue: 182/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }
}

