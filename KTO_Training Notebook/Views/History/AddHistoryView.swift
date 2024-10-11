//
//  AddHistoryView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//

import SwiftUI

struct AddHistoryView: View {
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
                    TextField("Text", text: $vm.simpleHistoryTitle)
                        .padding()
                        .background {Color.white.opacity(0.05).cornerRadius(12)}
                        .focused($keyBoardIfFocused)
                }
                
                //MARK: - Date
                DatePicker("Date", selection: $vm.simpleHistoryDate, displayedComponents: .date)
                
                HStack{
                    //MARK: - Begining
                    VStack{
                        Text("Begining")
                        TextField("Text", text: $vm.simpleHistoryBegining)
                            .padding()
                            .background {Color.white.opacity(0.05).cornerRadius(12)}
                            .focused($keyBoardIfFocused)
                    }
                    
                    //MARK: - Ending
                    VStack{
                        Text("Ending")
                        TextField("Text", text: $vm.simpleHistoryEnding)
                            .padding()
                            .background {Color.white.opacity(0.05).cornerRadius(12)}
                            .focused($keyBoardIfFocused)
                    }
                }
            }
        }
        .padding()
        .background {
            Color.brownApp.cornerRadius(12)
        }
        
        //MARK: - Training
        VStack{
            Button {
                vm.isPresentAddTrainingChoose = true
            } label: {
                ZStack {
                    Color.white.opacity(0.05)
                        .cornerRadius(12)
                    Text("Choose a workout")
                        .foregroundStyle(.white)
                }.frame(height: 50)
            }
            
            if vm.simpleTrainingChoose != nil {
                TrainingCellView(training: vm.simpleTrainingChoose!)
            }
        }.padding()
            .background {
                Color.brownApp.cornerRadius(12)
            }
        
        Spacer()
        
        //MARK: - Save button
        Button {
            vm.addHistory()
            dismiss()
        } label: {
            RedButtonView(text: "Save")
        }
        
        
        .sheet(isPresented: $vm.isPresentAddTrainingChoose, content: {
            TrainingForHistoryView(vm: vm)
        })
        .padding()
        .onTapGesture {
            keyBoardIfFocused = false
        }
    }
    
}

#Preview {
    AddHistoryView(vm: HomeViewModel())
}
