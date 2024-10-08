//
//  ExercisesView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct ExercisesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            //MARK: - Exercises count
            VStack {
                Text("0")
                    .font(.title)
                Text("exercises added")
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(content: {
                Color.brownApp.cornerRadius(12)
            })
            
            //MARK: - Category
            ScrollView(.horizontal) {
                HStack {
                    Text("All")
                        .foregroundStyle(.white)
                        .padding(8)
                        .background {
                            Color.red
                                .cornerRadius(12)
                        }
                    ForEach(CategoryExercises.allCases ,id: \.self) { category in
                        Button {
                            ///action
                        } label: {
                            Text(category.rawValue)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background {
                                    Color.red
                                        .cornerRadius(12)
                                }
                        }
                        
                    }
                }
            }
            
            //MARK: - Exercises
            EmptryEntryView()
            Spacer()
            .navigationTitle("Exercises")
            
            //MARK: - Add button
            .toolbar {
                ToolbarItem {
                    Button {
                        ///Action
                    } label: {
                        Text("Add")
                            .padding(8)
                            .background(Color.brownApp.cornerRadius(12))
                    }

                   
                }
            }
        }.padding()
    }
}

#Preview {
    NavigationView {
        ExercisesView()
    }
}
