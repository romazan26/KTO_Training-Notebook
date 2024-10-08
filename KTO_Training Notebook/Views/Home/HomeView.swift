//
//  HomeView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                //MARK: - User info
                UserInfoView()
                
                //MARK: - Group of button
                HStack{
                    HomeButtonView(imageName: "doc.richtext.fill")
                    HomeButtonView(imageName: "clock.fill")
                    HomeButtonView(imageName: "gearshape.fill")
                }
                
                //MARK: - Exercises
                VStack{
                    HStack{
                        Text("Exercises")
                            .font(.system(size: 28, weight: .heavy))
                        Spacer()
                        Text("Add")
                            .padding(8)
                            .background(Color.brownApp.cornerRadius(12))
                    }
                    Text("You haven't added any entries")
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color.brownApp.cornerRadius(12))
                }
                
                //MARK: - Training
                VStack{
                    HStack{
                        Text("Training")
                            .font(.system(size: 28, weight: .heavy))
                        Spacer()
                        Text("Add")
                            .padding(8)
                            .background(Color.brownApp.cornerRadius(12))
                    }
                    ScrollView {
                        EmptryEntryView()
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
