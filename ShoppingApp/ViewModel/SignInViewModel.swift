//
//  SignUpViewModel.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-28.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    static var signIn: SignInViewModel = SignInViewModel()
    
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var showError : Bool = false
    @Published var success : Bool = false
    @Published var errorMessage : String = ""
    @Published var isUserLogin: Bool = false
    
    func resetFields() {
        email = ""
        password = ""
    }
    
    
    //func for user SignIn
    func serviceCallLogin(){
        if(password.isEmpty) {
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
        }
        
        
        ServiceCall.post(parameter: ["email": email, "password": password, "dervice_token":""], path: Globs.SV_LOGIN) { responseObj in
            if let response = responseObj as? [String: Any] {
                if let status = response["status"] as? Int, status == 200 {
                    self.isUserLogin = true
                    self.resetFields()
                } else {
                    self.errorMessage = response["message"] as? String ?? "Fail"
                    self.showError = true
                }
            } else {
                self.errorMessage = "Invalid response format"
                self.showError = true
            }
        }failure: { error in
            print(String(describing: error))
        }
        
    }
    
}

