//
// UserProfileView.swift
//
// Created by Speedyfriend67 on 23.07.24
//
 
import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        NavigationView {
            VStack {
                Text("User Profile")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                
                Text("Welcome, user!")
                    .font(.title2)
                    .padding(.bottom, 20)
                
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
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(AuthenticationService())
    }
}