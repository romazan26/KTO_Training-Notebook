//
//  ExerciseView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 10.10.2024.
//

import SwiftUI

struct ExerciseView: View {
    
    @ObservedObject var exercise: Exercises
    @StateObject var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            //MARK: - Image
            if let image = exercise.image{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 146, height: 146)
            }
            
            //MARK: - Categoryes
            if let categorys = exercise.category?.allObjects as? [Category] {
                HStack {
                    ForEach(categorys) { category in
                        Text(category.nameCategory ?? "")
                            .foregroundStyle(.gray)
                            .padding(8)
                            .background {
                                Color.brownApp
                                    .cornerRadius(12)
                            }
                    }
                }
            }
            
            //MARK: - Descripton
            Text(exercise.descript ?? "")
                
            Spacer()
            
            //MARK: - Buttons
            HStack {
                Button {
                    vm.deleteExercise(exercise)
                    dismiss()
                } label: {
                    ZStack {
                        Color.brownApp.cornerRadius(12)
                        Text("Delete")
                    }.frame(height: 50)
                        
                }
                
                Button {
                    vm.fillexercises(exercise: exercise)
                    vm.isPresentEditExercise = true
                    vm.isEditModel = true
                } label: {
                    RedButtonView(text: "Edit")
                }


            }
        }
        .sheet(isPresented: $vm.isPresentEditExercise, content: {
            AddExercisesView(vm: vm)
        })
        .padding()
        .navigationTitle(exercise.titleExercises ?? "")
    }
}

//#Preview {
//    ExerciseView(exercise: Exercises(), vm: HomeViewModel())
//}
