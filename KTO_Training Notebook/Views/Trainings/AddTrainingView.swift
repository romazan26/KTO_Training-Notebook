//
//  AddTrainingView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 10.10.2024.
//

import SwiftUI

struct AddTrainingView: View {
    @StateObject var vm: HomeViewModel
    @FocusState var keyBoardIfFocused: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            //MARK: - Title view
            Text("Add")
                .font(.title2)
            VStack {
                //MARK: - Title
                VStack(alignment: .leading) {
                    Text("Title")
                    TextField("Text", text: $vm.simpleTrainingTitle)
                        .padding()
                        .background {Color.white.opacity(0.05).cornerRadius(12)}
                        .focused($keyBoardIfFocused)
                }
                
                //MARK: - Descript
                VStack(alignment: .leading) {
                    Text("Description")
                    MultiLineTF(txt: $vm.simpleTrainingDescript, placehold: "Text")
                        .frame(height: 160)
                        .padding()
                        .background {Color.white.opacity(0.05).cornerRadius(12)}
                        .focused($keyBoardIfFocused)
                }
            }
            .padding()
            .background {
                Color.brownApp.cornerRadius(12)
            }
            
            //MARK: - Exercises
            VStack{
                Button {
                    vm.isPresentAddExercises = true
                } label: {
                    ZStack {
                        Color.white.opacity(0.05)
                            .cornerRadius(12)
                        HStack {
                            Image(systemName: "pencil")
                            Text("Edit exercises")
                        }.foregroundStyle(.white)
                    }.frame(height: 50)
                }

                if !vm.arrayExercises.isEmpty {
                    VStack{
                        ScrollView {
                            ForEach(vm.arrayExercises) { exercise in
                                ExercisesCellView(exercese: exercise)
                            }
                        }
                    }
                }
            }.padding()
                .background {
                    Color.brownApp.cornerRadius(12)
                }
            
            Spacer()
            
            //MARK: - Save button
            Button {
                if vm.isEditModel {
                    vm.editTraining()
                }else{
                    vm.addTraining()
                    dismiss()
                }
                
            } label: {
                RedButtonView(text: "Save")
            }

        }
        .sheet(isPresented: $vm.isPresentAddExercises, content: {
            ExercisesFortrainingview(vm: vm)
        })
        .padding()
            .onTapGesture {
                keyBoardIfFocused = false
            }
    }
}

#Preview {
    AddTrainingView(vm: HomeViewModel())
}
