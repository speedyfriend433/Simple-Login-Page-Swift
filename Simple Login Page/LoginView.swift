//
// LoginView.swift
//
// Created by Speedyfriend67 on 23.07.24
//
 
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showingSignUp = false
    @State private var showingPasswordReset = false
    @State private var loginFailed = false
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
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
                
                if loginFailed {
                    Text("Login failed. Try again.")
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    authService.login(email: email, password: password) { success in
                        if !success {
                            loginFailed = true
                        } else {
                            loginFailed = false
                        }
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    showingSignUp = true
                }) {
                    Text("Don't have an account? Sign Up")
                }
                .sheet(isPresented: $showingSignUp) {
                    SignUpView()
                        .environmentObject(authService)
                }
                
                Button(action: {
                    showingPasswordReset = true
                }) {
                    Text("Forgot Password?")
                }
                .sheet(isPresented: $showingPasswordReset) {
                    PasswordResetView()
                        .environmentObject(authService)
                }
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationService())
    }
}