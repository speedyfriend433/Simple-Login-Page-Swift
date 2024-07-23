//
// My App.swift
//
// Created by Speedyfriend67 on 23.07.24
//

import SwiftUI

@main
struct SignInApp: App {
    @StateObject private var authService = AuthenticationService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authService)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        if authService.isAuthenticated {
            UserProfileView()
        } else {
            LoginView()
        }
    }
}
