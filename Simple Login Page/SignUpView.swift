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
    @State private var name = ""
    @State private var profileImage: UIImage? = nil
    @State private var profileImageURL: URL? = nil
    @State private var showImagePicker = false
    @State private var signUpFailed = false
    @State private var errorMessage = ""
    @State private var showVerificationView = false
    @EnvironmentObject var authService: AuthenticationService
    @Environment(\.presentationMode) var presentationMode
    
    private var containsUppercase: Bool {
        return password.range(of: "[A-Z]", options: .regularExpression) != nil
    }
    
    private var containsSpecialCharacter: Bool {
        return password.range(of: "[!@#$&*]", options: .regularExpression) != nil
    }
    
    private var containsNumber: Bool {
        return password.range(of: "[0-9]", options: .regularExpression) != nil
    }
    
    private var isPasswordLongEnough: Bool {
        return password.count >= 5
    }
    
    private var isPasswordValid: Bool {
        return containsUppercase && containsSpecialCharacter && containsNumber && isPasswordLongEnough
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
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
                
                VStack(alignment: .leading) {
                    CheckBoxView(isChecked: .constant(containsUppercase), text: "Contains 1 uppercase letter")
                    CheckBoxView(isChecked: .constant(containsSpecialCharacter), text: "Contains 1 special character")
                    CheckBoxView(isChecked: .constant(containsNumber), text: "Contains 1 number")
                    CheckBoxView(isChecked: .constant(isPasswordLongEnough), text: "Minimum 5 characters")
                }
                .padding(.bottom, 20)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                Button(action: {
                    showImagePicker = true
                }) {
                    Text("Select Profile Image")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 20)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $profileImage)
                }
                
                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.bottom, 20)
                }
                
                if signUpFailed {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    if password != confirmPassword {
                        errorMessage = "Passwords do not match."
                        signUpFailed = true
                    } else if !isPasswordValid {
                        errorMessage = "Password does not meet criteria."
                        signUpFailed = true
                    } else {
                        // Convert UIImage to URL
                        if let profileImage = profileImage, let data = profileImage.jpegData(compressionQuality: 0.8) {
                            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".jpg")
                            try? data.write(to: fileURL)
                            profileImageURL = fileURL
                        }
                        
                        authService.signUp(email: email, password: password, name: name, profileImageURL: profileImageURL) { success in
                            if !success {
                                errorMessage = "Sign Up failed. User already exists."
                                signUpFailed = true
                            } else {
                                signUpFailed = false
                                showVerificationView = true
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
                .sheet(isPresented: $showVerificationView) {
                    EmailVerificationView()
                        .environmentObject(authService)
                }
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
