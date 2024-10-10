//
//  ExercisesView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct ExercisesView: View {
    @StateObject var vm: HomeViewModel
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
                    ForEach(CategoryExercises.allCases ,id: \.self) { category in
                        Button {
                            vm.simpleCategory = category
                            vm.sorting()
                        } label: {
                            Text(category.rawValue)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background {
                                    Color(vm.simpleCategory == category ? .red : .gray)
                                        .cornerRadius(12)
                                }
                        }
                        
                    }
                }
            }
            
            //MARK: - Exercises
            if vm.exercises.isEmpty{
                EmptryEntryView()
            }else{
                ScrollView {
                    ForEach(vm.sortExercises) { exercise in
                        NavigationLink {
                            ExerciseView(exercise: exercise, vm: vm)
                        } label: {
                            ExercisesCellView(exercese: exercise)
                        }
                    }
                }
            }
            
            
            Spacer()
            
                .navigationTitle("Exercises")
            
            //MARK: - Add button
                .toolbar {
                    ToolbarItem {
                        NavigationLink {
                            AddExercisesView(vm: vm)
                        } label: {
                            Text("Add")
                                .padding(8)
                                .background(Color.brownApp.cornerRadius(12))
                        } 
                    }
                }
        }
        .padding()
        .onAppear {
            vm.sorting()
        }
    }
}

#Preview {
    NavigationView {
        ExercisesView(vm: HomeViewModel())
    }
}
