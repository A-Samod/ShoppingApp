//
//  SwiftUIView.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack{
            Image("welcome_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                Spacer()
                
                Text("Welcome\nto our store")
                    .font(.customfont( .semibold, fontSize: 48))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                NavigationLink {
                    LoginView()
                } label: {
                    RoundButton(title: "Get Started") {
                    }
                }
                
                Spacer()
                    .frame(height: 60)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct WelcomeView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationView{
            WelcomeView()
        }
    }
}
