//
//  MainTabView.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-26.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        ZStack{
            
            VStack{
                
      //          Spacer()
                
                HStack{
                    Button{
                      MainViewModel.shared.isUserLogin=false
                    } label: {
                            Text("Logout")
                        }
                    }
                                    
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainTabView()
        }
        
    }
}
