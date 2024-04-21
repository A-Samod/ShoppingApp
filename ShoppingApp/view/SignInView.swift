//
//  LoginView.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-24.
//

import SwiftUI

struct SignInView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var loginVM = SignInViewModel.signIn;
    @State private var showPassword = false
    @State private var navigateToLogIn = false
    
    var body: some View {
        ZStack {
            Image("")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            Image("home_logo_cropped")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,-350)
            VStack{
                
                Text("Sign In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Enter your emails and password")
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, .screenWidth * 0.1)
                
                
                VStack(spacing: 20) {
                    TextField("Email", text: $loginVM.email)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .frame(height: 50)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    VStack {
                        if showPassword {
                            TextField("Password", text: $loginVM.password)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .frame(height: 50)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        } else {
                            SecureField("Password", text: $loginVM.password)
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
                    .frame(height: 50)
                    .padding(.bottom, 20)
                }
                Button {
                    
                } label: {
                    Text("Forgot Password?")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.black)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, .screenWidth * 0.03)
                
                RoundButton(title: "Login") {
                    loginVM.serviceCallLogin()
                    navigateToLogIn=true
                }
                .fullScreenCover(isPresented: $navigateToLogIn) {
                    HomeView()
                }
                .padding(.bottom, .screenWidth * 0.05)
                NavigationLink {
                    SignUpView()
                } label: {
                    HStack{
                        Text("Don't have an account?")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.black)
                        
                        Text("Signup")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 220)
            .padding(.horizontal, 20)
     
        }
        .alert(isPresented: $loginVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text( loginVM.errorMessage ), dismissButton: .default(Text("Ok")))
        }
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
            SignInView()
    }
}
