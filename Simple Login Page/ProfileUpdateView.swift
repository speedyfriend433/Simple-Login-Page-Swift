//
// ProfileUpdateView.swift
//
// Created by Speedyfriend67 on 23.07.24
//
 
import SwiftUI

struct ProfileUpdateView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var profileImage: UIImage? = nil
    @State private var profileImageURL: URL? = nil
    @State private var showImagePicker = false
    @State private var updateFailed = false
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        VStack {
            Text("Update Profile")
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
            
            if updateFailed {
                Text("Update failed. Try again.")
                    .foregroundColor(.red)
            }
            
            Button(action: {
                // Convert UIImage to URL
                if let profileImage = profileImage, let data = profileImage.jpegData(compressionQuality: 0.8) {
                    let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".jpg")
                    try? data.write(to: fileURL)
                    profileImageURL = fileURL
                }
                
                authService.updateProfile(name: name, email: email, profileImageURL: profileImageURL) { success in
                    if !success {
                        updateFailed = true
                    } else {
                        updateFailed = false
                    }
                }
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
        }
        .padding()
        .onAppear {
            if let user = authService.currentUser {
                name = user.name
                email = user.email
                if let url = user.profileImageURL, let data = try? Data(contentsOf: url) {
                    profileImage = UIImage(data: data)
                }
            }
        }
    }
}

struct ProfileUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUpdateView()
            .environmentObject(AuthenticationService())
    }
}