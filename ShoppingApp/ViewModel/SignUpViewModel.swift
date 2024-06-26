//
//  SignUpViewModel.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-28.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    static var signUp: SignUpViewModel = SignUpViewModel()
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var showError : Bool = false
    @Published var success : Bool = false
    @Published var errorMessage : String = ""
    @Published var isUserSignUp: Bool = false
    
    func resetFields() {
        username = ""
        email = ""
        password = ""
    }
    
    //func for signUp
    func serviceCallSignUp(){
        
        if(username.isEmpty) {
            self.errorMessage = "please enter username"
            self.showError = true
            return
        }
        
        if(email.isEmpty) {
            self.errorMessage = "please enter valid email"
            self.showError = true
            return
        }
        
        
        if(password.isEmpty) {
            self.errorMessage = "please enter password"
            self.showError = true
            return
        }
        
        ServiceCall.post(parameter: [ "username": username , "email": email, "password": password, "dervice_token":"" ], path: Globs.SV_SIGN_UP) { responseObj in
            if let response = responseObj as? [String: Any] {
                
                if let status = response["status"] as? Int, status == 200 {
                    self.isUserSignUp = true
                    self.resetFields()
                }
                else {
                    self.errorMessage = response["message"] as? String ?? "Fail"
                    self.showError = true
                }
            } else {
                self.errorMessage = "Invalid response format"
                self.showError = true
            }
        }failure: { error in
            self.showError = true
        }
    }
    
}
