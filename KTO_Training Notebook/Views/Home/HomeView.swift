//
//  HomeView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
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
                        if vm.exercises.isEmpty{
                            NavigationLink {
                                AddExercisesView(vm: vm)
                            } label: {
                                Text("Add")
                                    .padding(8)
                                    .background(Color.brownApp.cornerRadius(12))
                            }
                        }else{
                            NavigationLink {
                                ExercisesView(vm: vm)
                            } label: {
                                Text("See all")
                                    .foregroundStyle(.red)
                            }

                        }
                       
                    }
                    if vm.exercises.isEmpty{
                        Text("You haven't added any entries")
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .background(Color.brownApp.cornerRadius(12))
                    }else{
                        
                            ScrollView(.horizontal) {
                                HStack{
                                ForEach(vm.exercises.prefix(3)) { exercise in
                                    ExercisesMiniCellView(exercises: exercise)
                                }
                            }
                        }
                    }
                    
                }
                
                //MARK: - Training
                VStack{
                    HStack{
                        Text("Training")
                            .font(.system(size: 28, weight: .heavy))
                        Spacer()
                        if vm.trainings.isEmpty{
                            NavigationLink {
                                AddTrainingView(vm: vm)
                            } label: {
                                Text("Add")
                                    .padding(8)
                                    .background(Color.brownApp.cornerRadius(12))
                            }
                        }else{
                            NavigationLink {
                                TrainingsView(vm: vm)
                            } label: {
                                Text("See all")
                                    .padding(8)
                                    .background(Color.brownApp.cornerRadius(12))
                            }
                        }
                       
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
