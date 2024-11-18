//
//  AboutUsView.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-17.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        NavigationView {
            Text("Welcome to the About Us page!")
                .font(.title)
                .padding()
                .navigationTitle("About Us")
        }
    }
}

#Preview {
    AboutUsView()
}
