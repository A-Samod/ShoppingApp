//
//  MainViewModel.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-24.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
//    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Published var txtUsername: String = ""
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var isUserLogin: Bool = false
    @Published var userObj: UserModel = UserModel(dict: [:])
    @Published var success: Bool = false
    
    //MARK: ServiceCall
    func serviceCallLogin(){
        
        if(!txtEmail.isValidEmail) {
            self.errorMessage = "please enter valid email address"
            self.showError = true
            return
        }
        
        if(txtPassword.isEmpty) {
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
        }
        
        print("txtEmail" ,txtEmail)
        print("txtPassword" ,txtPassword)
        
        ServiceCall.post(parameter: ["email": txtEmail, "password": txtPassword, "dervice_token":""], path: Globs.SV_LOGIN) { responseObj in
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
            //            self.errorMessage = error?.localizedDescription ?? "Fail"
            //            self.showError = true
            print(String(describing: error))
        }
        
    }
    
    func serviceCallSignUp(){
        
        if(txtUsername.isEmpty) {
            self.errorMessage = "please enter valid username"
            self.showError = true
            return
        }
        
        
                if(!txtEmail.isValidEmail) {
                    self.errorMessage = "please enter valid email address"
                    self.showError = true
                    return
                }
        
        if(txtPassword.isEmpty) {
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
        }
        
        print("txtEmail" ,txtEmail)
        print("txtPassword" ,txtPassword)
        
        
        ServiceCall.post(parameter: [ "username": txtUsername , "email": txtEmail, "password": txtPassword, "dervice_token":"" ], path: Globs.SV_SIGN_UP) { responseObj in
            if let response = responseObj as? [String: Any] {
                print("response 2====>>>", response)
                
                if let status = response["status"] as? Int, status == 200 {
                    self.errorMessage = response["message"] as? String ?? "Success"
                    self.showError = true
                } else {
                    self.errorMessage = response["message"] as? String ?? "Fail"
                    self.showError = true
                }
            } else {
                self.errorMessage = "Invalid response format"
                self.showError = true
            }
        }failure: { error in
            // self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
            
}

