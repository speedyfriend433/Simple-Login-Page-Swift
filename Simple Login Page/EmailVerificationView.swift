//
// EmailVerificationView.swift
//
// Created by Speedyfriend67 on 23.07.24
//
 
import SwiftUI

struct EmailVerificationView: View {
    @State private var verificationCode = ""
    @EnvironmentObject var authService: AuthenticationService
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Email Verification")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            TextField("Verification Code", text: $verificationCode)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .padding(.bottom, 20)
            
            Button(action: {
                // Here you would verify the code with your backend
                let isVerified = verificationCode == "123456" // Mock verification code
                if isVerified {
                    authService.isAuthenticated = true
                    presentationMode.wrappedValue.dismiss()
                } else {
                    // Show an error message
                }
            }) {
                Text("Verify")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding(.bottom, 20)
        }
        .padding()
    }
}

struct EmailVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerificationView()
            .environmentObject(AuthenticationService())
    }
}