//
//  SignIn.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-24.
//

import SwiftUI

struct SignInView:View {
    var body: some View {
        ZStack(alignment: .top){
            VStack{
                Image("splash")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenWidth)
                
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
   
    }
    
     
}

struct SignInView_Previews: PreviewProvider{
    static var previews: some View{
        SignInView()
    }
}
