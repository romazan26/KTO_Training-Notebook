//
//  TrainingView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//

import SwiftUI

struct TrainingView: View {
    @StateObject var vm: HomeViewModel
    @ObservedObject var training: Training
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            //MARK: - training description
            Text(training.descript ?? "")
                .navigationTitle(training.title ?? "")
            
            //MARK: - Training exercise
            if let exercises = training.exercises?.allObjects as? [Exercises] {
                ScrollView{
                    ForEach(exercises) { exercise in
                        ExercisesCellView(exercese: exercise)
                    }
                }
            }
            
            Spacer()
            
            //MARK: - Delete and edit button
            HStack{
                Button {
                    vm.deleteTraining(training)
                    dismiss()
                } label: {
                    ZStack {
                        Color.brownApp.cornerRadius(12)
                        Text("Delete")
                    }.frame(height: 50)
                        
                }
                
                Button {
                    vm.fiilTraining(training: training)
                    vm.isPresentEditTraining = true
                    vm.isEditModel = true
                } label: {
                    RedButtonView(text: "Edit")
                }
            }
        }
        .sheet(isPresented: $vm.isPresentEditTraining, content: {
            AddTrainingView(vm: vm)
        })
        .padding()
    }
}

#Preview {
    NavigationView {
        TrainingView(vm: HomeViewModel(), training: Training())
    }
}
