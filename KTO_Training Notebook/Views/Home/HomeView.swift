//
//  HomeView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    @StateObject var vmUser = UserViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 15) {
                    //MARK: - User info
                    UserInfoView(vm: vmUser)
                        .onTapGesture {
                            vm.ispresentUser.toggle()
                        }
                    
                    //MARK: - Group of button
                    HStack{
                        //MARK: History button
                        NavigationLink {
                            HistorysView(vm: vm)
                        } label: {
                            HomeButtonView(imageName: "doc.richtext.fill")
                        }
                        
                        //MARK: - Timer
                        NavigationLink {
                            TimerView()
                        } label: {
                            HomeButtonView(imageName: "clock.fill")
                        }
                        
                        //MARK: - Setting button
                        Button {
                            vm.isPresentSetting.toggle()
                        } label: {
                            HomeButtonView(imageName: "gearshape.fill")
                        }
                        
                        
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
                            if vm.trainings.isEmpty{
                                EmptryEntryView()
                            }else{
                                ForEach(vm.trainings.prefix(2)) { training in
                                    TrainingCellView(training: training)
                                }
                            }
                            Text("Enter see all button")
                        }
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("Home")
                
                //MARK: - Setting View
                if vm.isPresentSetting{
                    SettingsView(isPresent: $vm.isPresentSetting)
                }
                
                    
                //MARK: - Setting View
                if vm.ispresentUser{
                    UserSettingsView(isPresented: $vm.ispresentUser, vm: vmUser)
                }
            }
            .animation(.easeInOut, value: vm.isPresentSetting)
            .animation(.easeInOut, value: vm.ispresentUser)
        }
    }
}

#Preview {
    HomeView()
}
