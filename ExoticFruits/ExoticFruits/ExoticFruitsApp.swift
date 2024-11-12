//
//  ExoticFruitsApp.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-08.
//

import SwiftUI


@main
struct ExoticFruitsApp: App {       
       var body: some Scene {
           WindowGroup {
               ExoticFruitListView()
//               NavigationView {
//                   ListView()
//                       .environmentObject(itemApi)
//               }
           }
       }
   }
