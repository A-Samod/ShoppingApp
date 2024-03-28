//
//  SignUpViewModel.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-28.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    static var shared: SignUpViewModel = SignUpViewModel()
    //    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var showError : Bool = false
    @Published var success : Bool = false
    @Published var errorMessage : String = ""
    @Published var isShowPassword: Bool = false
    @Published var isUserLogin: Bool = false
    
    //MARK: ServiceCall
    func serviceCallLogin(){
        
        
        if(password.isEmpty) {
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
        }
        
        
        ServiceCall.post(parameter: ["email": email, "password": password, "dervice_token":""], path: Globs.SV_LOGIN) { responseObj in
            if let response = responseObj as? [String: Any] {
                print("response 2====>>>", response)
                
                if let status = response["status"] as? Int, status == 200 {
                    self.errorMessage = response["message"] as? String ?? "Success"
                    self.showError = true
                    
                    self.isUserLogin = true
                    
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
                print("response 2====>>>", response)
                
                if let status = response["status"] as? Int, status == 200 {
                    self.errorMessage = response["message"] as? String ?? "Success"
                    self.showError = true
                }
                if let status = response["status"] as? Int, status == 404 {
                    self.errorMessage = response["message"] as? String ?? "Invalid username or password"
                    self.showError = true
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
