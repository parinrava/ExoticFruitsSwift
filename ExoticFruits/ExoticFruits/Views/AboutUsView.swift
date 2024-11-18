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
            ZStack {
                // Set the background color for the entire screen
                Color("backgroundColor")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // First Person
                        VStack {
                            Image("parin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.gray, lineWidth: 2)
                                )
                                .shadow(radius: 5)

                            Text("Paris Ravanbakhsh")
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("Student Number: A01289277")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding(50)

                        // Second Person
                        VStack {
                            Image("alfrey")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.gray, lineWidth: 2)
                                )
                                .shadow(radius: 5)

                            Text("Alfrey Chan")
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("Student Number: A01344049")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                    .padding()
                }
            }
            .navigationTitle("About Us")
        }
    }
}

#Preview {
    AboutUsView()
}
