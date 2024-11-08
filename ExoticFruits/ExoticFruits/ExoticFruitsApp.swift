//
//  ExoticFruitsApp.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-08.
//

import SwiftUI


@main
struct ExoticFruitsApp: App {
    @StateObject private var itemApi = ItemApi()
       
       var body: some Scene {
           WindowGroup {
               NavigationView {
                   ListView()
                       .environmentObject(itemApi)
               }
           }
       }
   }
