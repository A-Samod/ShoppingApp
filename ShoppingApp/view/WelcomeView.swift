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
                .scaledToFit()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                Spacer()
                
                Text("WELCOME\n TO\n FUTURE FASHION")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding()
                    .multilineTextAlignment(.center)
                
                NavigationLink {
                    SignInView()
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
