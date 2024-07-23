import Foundation
import Combine

struct User {
    var email: String
    var password: String
    var name: String
    var profileImageURL: URL?
}

class AuthenticationService: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User? = nil
    private var registeredUsers: [String: User] = [:] // Mock user storage
    
    init() {
        loadUser()
    }
    
    func signUp(email: String, password: String, name: String, profileImageURL: URL?, completion: @escaping (Bool) -> Void) {
        let lowercasedEmail = email.lowercased()
        if registeredUsers[lowercasedEmail] == nil {
            let user = User(email: lowercasedEmail, password: password, name: name, profileImageURL: profileImageURL)
            registeredUsers[lowercasedEmail] = user
            currentUser = user
            saveUser()
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let lowercasedEmail = email.lowercased()
        if let user = registeredUsers[lowercasedEmail], user.password == password {
            isAuthenticated = true
            currentUser = user
            saveUser()
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func updateProfile(name: String, email: String, profileImageURL: URL?, completion: @escaping (Bool) -> Void) {
        guard var user = currentUser else {
            completion(false)
            return
        }
        let lowercasedEmail = email.lowercased()
        if user.email != lowercasedEmail, registeredUsers[lowercasedEmail] != nil {
            completion(false)
        } else {
            registeredUsers.removeValue(forKey: user.email)
            user.email = lowercasedEmail
            user.name = name
            user.profileImageURL = profileImageURL
            registeredUsers[lowercasedEmail] = user
            currentUser = user
            saveUser()
            completion(true)
        }
    }
    
    func changePassword(currentPassword: String, newPassword: String, completion: @escaping (Bool) -> Void) {
        guard var user = currentUser, user.password == currentPassword else {
            completion(false)
            return
        }
        user.password = newPassword
        registeredUsers[user.email] = user
        currentUser = user
        saveUser()
        completion(true)
    }
    
    func resetPassword(email: String, newPassword: String, completion: @escaping (Bool) -> Void) {
        let lowercasedEmail = email.lowercased()
        if var user = registeredUsers[lowercasedEmail] {
            user.password = newPassword
            registeredUsers[lowercasedEmail] = user
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func logout() {
        isAuthenticated = false
        currentUser = nil
        clearUser()
    }
    
    private func saveUser() {
        guard let user = currentUser else { return }
        UserDefaults.standard.setValue(user.email, forKey: "email")
        UserDefaults.standard.setValue(user.password, forKey: "password")
        UserDefaults.standard.setValue(user.name, forKey: "name")
        if let profileImageURL = user.profileImageURL {
            UserDefaults.standard.setValue(profileImageURL.absoluteString, forKey: "profileImageURL")
        }
    }
    
    private func loadUser() {
        if let email = UserDefaults.standard.string(forKey: "email"),
           let password = UserDefaults.standard.string(forKey: "password"),
           let name = UserDefaults.standard.string(forKey: "name"),
           let user = registeredUsers[email.lowercased()],
           user.password == password {
            currentUser = user
            isAuthenticated = true
        }
    }
    
    private func clearUser() {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "profileImageURL")
    }
}