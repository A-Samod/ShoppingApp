//
//  SignUpView.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-26.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var mainVM = SignUpViewModel.shared;
    //@ObservedObject var mainVM: RegisterViewModel = RegisterViewModel()
    
    var body: some View {
        ZStack{
            
            ScrollView {
                VStack{
                    
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("Enter your credentials to continue")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    
                    LineTextField( title: "Username", placholder: "Enter your username", txt: $mainVM.username)
                        .padding(.bottom, .screenWidth * 0.07)
                    
                    LineTextField( title: "Email", placholder: "Enter your email address", txt: $mainVM.email, keyboardType: .emailAddress)
                        .padding(.bottom, .screenWidth * 0.07)
                    
                    LineSecureField( title: "Password", placholder: "Enter your password", txt: $mainVM.password, isShowPassword: $mainVM.isShowPassword)
                        .padding(.bottom, .screenWidth * 0.04)
                    
                    VStack {
                        Text("By continuing you agree to our")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            
                            Text("Terms of Service")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.blue)
                            
                            
                            Text(" and ")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.blue)
                            
                            
                            Text("Privacy Policy.")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.blue)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .padding(.bottom, .screenWidth * 0.02)
                    }
                    
                    
                    RoundButton(title: "Sign Up") {
                        mainVM.serviceCallSignUp()
                        print("Clicked ..")
//                        mainVM.resetFields()
                    }
                    .padding(.bottom, .screenWidth * 0.05)
                    
                    
                    NavigationLink {
                        SignInView()
                    } label: {
                        HStack{
                            Text("Alredy have an account?")
                                .font(.customfont(.semibold, fontSize: 14))
                                .foregroundColor(.primaryText)
                            
                            Text("Sign In")
                                .font(.customfont(.semibold, fontSize: 14))
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top,  .topInsets + 64)
                .padding(.horizontal, 20)
                .padding(.bottom, .bottomInsets)
            }
            
            
        }
        .alert(isPresented: $mainVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(mainVM.errorMessage) , dismissButton: .default(Text("Ok")))
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
