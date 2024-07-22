import Foundation
import Combine

class AuthenticationService: ObservableObject {
    @Published var isAuthenticated = false
    private var registeredUsers: [String: String] = [:] // Mock user storage
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        if registeredUsers[email.lowercased()] == nil {
            registeredUsers[email.lowercased()] = password
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        if let storedPassword = registeredUsers[email.lowercased()], storedPassword == password {
            isAuthenticated = true
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func resetPassword(email: String, newPassword: String, completion: @escaping (Bool) -> Void) {
        if registeredUsers[email.lowercased()] != nil {
            registeredUsers[email.lowercased()] = newPassword
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func logout() {
        isAuthenticated = false
    }
}