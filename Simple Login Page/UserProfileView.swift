//
// UserProfileView.swift
//
// Created by Speedyfriend67 on 23.07.24
//
 
import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var authService: AuthenticationService
    @State private var showingProfileUpdate = false
    @State private var showingChangePassword = false
    
    var body: some View {
        VStack {
            Text("User Profile")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            Text("Welcome, \(authService.currentUser?.name ?? "user")!")
                .font(.title2)
                .padding(.bottom, 20)
            
            Button(action: {
                showingProfileUpdate = true
            }) {
                Text("Update Profile")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding(.bottom, 20)
            .sheet(isPresented: $showingProfileUpdate) {
                ProfileUpdateView()
                    .environmentObject(authService)
            }
            
            Button(action: {
                showingChangePassword = true
            }) {
                Text("Change Password")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.orange)
                    .cornerRadius(15.0)
            }
            .padding(.bottom, 20)
            .sheet(isPresented: $showingChangePassword) {
                ChangePasswordView()
                    .environmentObject(authService)
            }
            
            Button(action: {
                authService.logout()
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.red)
                    .cornerRadius(15.0)
            }
            .padding(.bottom, 20)
        }
        .padding()
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(AuthenticationService())
    }
}
