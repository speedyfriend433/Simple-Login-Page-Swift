//
// PasswordResetView.swift
//
// Created by Speedyfriend67 on 23.07.24
//
 
import SwiftUI

struct PasswordResetView: View {
    @State private var email = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var resetFailed = false
    @State private var successMessage = ""
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Reset Password")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                SecureField("New Password", text: $newPassword)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                SecureField("Confirm New Password", text: $confirmPassword)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                if resetFailed {
                    Text("Reset failed. Try again.")
                        .foregroundColor(.red)
                } else if !successMessage.isEmpty {
                    Text(successMessage)
                        .foregroundColor(.green)
                }
                
                Button(action: {
                    if newPassword != confirmPassword {
                        resetFailed = true
                        successMessage = ""
                    } else {
                        authService.resetPassword(email: email, newPassword: newPassword) { success in
                            if success {
                                resetFailed = false
                                successMessage = "Password reset successful."
                            } else {
                                resetFailed = true
                                successMessage = ""
                            }
                        }
                    }
                }) {
                    Text("Reset Password")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.orange)
                        .cornerRadius(15.0)
                }
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView()
            .environmentObject(AuthenticationService())
    }
}