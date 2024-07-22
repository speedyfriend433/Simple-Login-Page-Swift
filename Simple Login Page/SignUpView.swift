//
// SignUpView.swift
//
// Created by Speedyfriend67 on 23.07.24
//
 
import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var signUpFailed = false
    @State private var errorMessage = ""
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                if signUpFailed {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    if password != confirmPassword {
                        errorMessage = "Passwords do not match."
                        signUpFailed = true
                    } else {
                        authService.signUp(email: email, password: password) { success in
                            if !success {
                                errorMessage = "Sign Up failed. User already exists."
                                signUpFailed = true
                            } else {
                                signUpFailed = false
                            }
                        }
                    }
                }) {
                    Text("Sign Up")
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
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthenticationService())
    }
}