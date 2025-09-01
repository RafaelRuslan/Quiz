//
//  LoginViewModel.swift
//  Quiz
//
//  Created by Rafael Agayev on 29.08.25.
//

import SwiftUI
import FirebaseAuth
import Firebase

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showWelcome: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
        func loginUser() {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                } else {
                    self.showWelcome = true
                }
            }
        }
        
         func registerUser() {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                } else {
                    self.showWelcome = true
                }
            }
        }
    }
