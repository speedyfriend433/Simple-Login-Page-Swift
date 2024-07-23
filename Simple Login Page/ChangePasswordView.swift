//
// ChangePasswordView.swift
//
// Created by Speedyfriend67 on 23.07.24
//
 
import SwiftUI

struct ChangePasswordView: View {
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmNewPassword = ""
    @State private var changeFailed = false
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        VStack {
            Text("Change Password")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            SecureField("Current Password", text: $currentPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .padding(.bottom, 20)
            
            SecureField("New Password", text: $newPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .padding(.bottom, 20)
            
            SecureField("Confirm New Password", text: $confirmNewPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .padding(.bottom, 20)
            
            if changeFailed {
                Text("Change failed. Try again.")
                    .foregroundColor(.red)
            }
            
            Button(action: {
                if newPassword != confirmNewPassword {
                    changeFailed = true
                } else {
                    authService.changePassword(currentPassword: currentPassword, newPassword: newPassword) { success in
                        if !success {
                            changeFailed = true
                        } else {
                            changeFailed = false
                        }
                    }
                }
            }) {
                Text("Change Password")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            .padding(.bottom, 20)
        }
        .padding()
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
            .environmentObject(AuthenticationService())
    }
}