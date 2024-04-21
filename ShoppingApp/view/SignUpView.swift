//
//  SignUpView.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-26.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var mainVM = SignUpViewModel.signUp;
    @State private var showPassword = false
    @State private var showAlert = false
    
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
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    VStack(spacing: 20) {
                        
                        TextField("Username", text: $mainVM.username)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .frame(height: 70)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        TextField("Email", text: $mainVM.email)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .frame(height: 50)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        VStack {
                            if showPassword {
                                TextField("Password", text: $mainVM.password)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                    .frame(height: 50)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("Password", text: $mainVM.password)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                    .frame(height: 50)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            }
                        }
                        .overlay(
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                                    .foregroundColor(.gray)
                            }
                                .padding(.trailing, 10)
                            , alignment: .trailing
                        )
                        .frame(height: 60)
                        .padding(.bottom, 30)
                    }
                    
                    VStack {
                        Text("By continuing you agree to our")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.gray)
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
                    }.fullScreenCover(isPresented: $mainVM.isUserSignUp) {
                          SignInView()
                        }
                    .padding(.bottom, .screenWidth * 0.05)
                    NavigationLink {
                        SignInView()
                    } label: {
                        HStack{
                            Text("Already have an account?")
                                .font(.customfont(.semibold, fontSize: 14))
                                .foregroundColor(.black)
                            
                            Text("Sign In")
                                .font(.customfont(.semibold, fontSize: 14))
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 140)
                .padding(.horizontal, 20)
                // .padding(.bottom, .bottomInsets)
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
