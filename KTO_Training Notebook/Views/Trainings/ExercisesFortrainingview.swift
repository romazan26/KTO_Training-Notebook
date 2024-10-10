//
//  ExercisesFortrainingview.swift
//  KTO_Training Notebook
//
//  Created by Роман on 10.10.2024.
//

import SwiftUI

struct ExercisesFortrainingview: View {
    @StateObject var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Exercises")
                .font(.title2)
            if vm.exercises.isEmpty {
                EmptryEntryView()
            }else{
                VStack {
                    ScrollView {
                        ForEach(vm.exercises) { exercise in
                            HStack {
                                if vm.arrayExercises.contains(exercise){
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }else{
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                ExercisesCellView(exercese: exercise)
                            }.onTapGesture {
                                vm.oneMoreExercise(execise: exercise)
                            }
                        }
                    }
                }
                .padding()
                .background {
                    Color.brownApp.cornerRadius(12)
                }
            }
            Spacer()
            
            //MARK: - Save button
            Button {
                dismiss()
            } label: {
                RedButtonView(text: vm.exercises.isEmpty ? "Back" : "Save")
            }

        }.padding()
    }
}

#Preview {
    ExercisesFortrainingview(vm: HomeViewModel())
}
