//
//  AddExercisesView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 10.10.2024.
//

import SwiftUI

struct AddExercisesView: View {
    @StateObject var vm: HomeViewModel
    @FocusState var keyBoardIfFocused: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            //MARK: - Title view
            Text("Add")
                .font(.title2)
            VStack{
                //MARK: - Image exercises
                Button {
                    vm.isPresentPicker.toggle()
                } label: {
                    Image(uiImage: vm.simpleImage ?? UIImage(resource: .noExercises))
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(8)
                }
                
                //MARK: - Title Exercises
                VStack(alignment: .leading) {
                    Text("Title")
                    TextField("Text", text: $vm.simpleExerciseTitle)
                        .padding()
                        .background {Color.white.opacity(0.05).cornerRadius(12)}
                        .focused($keyBoardIfFocused)
                }
                
                //MARK: - Descript
                VStack(alignment: .leading) {
                    Text("Description")
                    MultiLineTF(txt: $vm.simpleDescriptExercises, placehold: "Text")
                        .frame(height: 160)
                        .padding()
                        .background {Color.white.opacity(0.05).cornerRadius(12)}
                        .focused($keyBoardIfFocused)
                }
            }
            .padding()
            .background {Color.brownApp.cornerRadius(12)}
            
            //MARK: - Category
            VStack(alignment: .leading){
                Text("Category")
                HStack {
                
                    Picker("", selection: $vm.simpleCategory){
                        
                        ForEach(CategoryExercises.allCases) { category in
                            if category.rawValue != "all"{
                                Text(category.rawValue).foregroundStyle(.gray)
                            }
                        }
                    }
                    .pickerStyle(.menu)
                    .foregroundStyle(.white)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background {
                        Color.white
                            .opacity(0.05)
                            .cornerRadius(12)
                    }
                    Button {
                        vm.omeMoreCategory()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.red)
                            .font(.title)
                    }

                }
                //MARK: - List new category
                HStack {
                    ForEach(vm.arrayCategory.indices, id: \.self) { i in
                        HStack {
                            Text(vm.arrayCategory[i])
                            Button {
                                vm.arrayCategory.remove(at: i)
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(10)
                        .foregroundStyle(.white)
                        .background {
                            Color.red.cornerRadius(10)
                        }
                    }
                }
            }
            
            Spacer()
            
            //MARK: - Save button
            Button {
                if vm.isEditModel{
                    vm.editExercise()
                }else{
                    vm.addExercise()
                }
                
                dismiss()
            } label: {
                RedButtonView(text: "Save")
            }


        }
        .onTapGesture {
            keyBoardIfFocused = false
        }
        .padding()
        .sheet(isPresented: $vm.isPresentPicker) {
            PhotoPicker(configuration: vm.config,
                        pickerResult: $vm.simpleImage,
                        isPresented: $vm.isPresentPicker)
        }
    }
}

#Preview {
    AddExercisesView(vm: HomeViewModel())
}
