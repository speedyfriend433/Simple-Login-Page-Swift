# SignIn App

This is a SwiftUI-based SignIn application that supports user registration, login, profile update, password change, and profile image upload. Additionally, it includes email verification functionality.

## Features

- User Registration with password validation (uppercase letter, special character, number, and minimum length).
- User Login.
- Profile Update including profile image upload.
- Password Change.
- Email Verification.

## Requirements

- iOS 15.6+
- Xcode 13.0+
- Swift 5.5+

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/SignInApp.git
    ```
2. Open the project in Xcode:
    ```bash
    cd SignInApp
    open SignInApp.xcodeproj
    ```
3. Build and run the project on the simulator or a physical device.

## Usage

### User Registration

1. Open the app.
2. Click on "Don't have an account? Sign Up".
3. Fill in your name, email, and password. Make sure the password meets the following criteria:
   - Contains at least 1 uppercase letter.
   - Contains at least 1 special character (!@#$&*).
   - Contains at least 1 number.
   - Minimum length of 5 characters.
4. Optionally, select a profile image by clicking "Select Profile Image".
5. Click "Sign Up".
6. Verify your email with the provided verification code.

### User Login

1. Open the app.
2. Enter your email and password.
3. Click "Login".

### Profile Update

1. After logging in, go to your profile.
2. Update your name and email as desired.
3. Optionally, select a new profile image.
4. Click "Update Profile".

### Password Change

1. After logging in, go to your profile.
2. Click on "Change Password".
3. Enter your current password, new password, and confirm the new password.
4. Make sure the new password meets the required criteria.
5. Click "Change Password".

### Email Verification

1. After signing up, an email with a verification code is sent.
2. Enter the verification code in the provided field.
3. Click "Verify".

## Project Structure

- `SignInApp.swift`: The main entry point of the app.
- `AuthenticationService.swift`: The service handling authentication and user management.
- `LoginView.swift`: The view for user login.
- `SignUpView.swift`: The view for user registration.
- `UserProfileView.swift`: The view for user profile.
- `ProfileUpdateView.swift`: The view for updating user profile.
- `ChangePasswordView.swift`: The view for changing the password.
- `EmailVerificationView.swift`: The view for email verification.
- `ImagePicker.swift`: The view for selecting profile images.
- `CheckBoxView.swift`: The custom view for displaying password validation criteria.

## Contributing

1. Fork the repository.
2. Create a new branch for your feature (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [Combine Framework](https://developer.apple.com/documentation/combine)
- [UIKit Documentation](https://developer.apple.com/documentation/uikit/)
