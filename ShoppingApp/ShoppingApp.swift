//
//  ShoppingAppApp.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-24.
//

import SwiftUI

@main
struct ShoppingApp: App {
    
   @StateObject var mainVM = MainViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                if mainVM.isUserLogin==true{
                    MainTabView()
                }
                else{
                    WelcomeView()
                }
               
            }
        }
    }
}
