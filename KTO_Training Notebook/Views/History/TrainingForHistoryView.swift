//
//  TrainingForHistoryView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//

import SwiftUI

struct TrainingForHistoryView: View {
    @StateObject var vm: HomeViewModel
    var body: some View {
        VStack {
            //MARK: - Tirle view
            Text("Training")
                .font(.title2)
            
            //MARK: - Training list
            ScrollView {
                if vm.trainings.isEmpty{
                    EmptryEntryView()
                }else{
                    ForEach(vm.trainings) { training in
                        TrainingCellView(training: training)
                            .overlay {
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.red.opacity(0.5), lineWidth: vm.simpleTrainingChoose == training ? 2.0 : 0.0)
                            }
                            .onTapGesture {
                                vm.simpleTrainingChoose = training
                            }
                    }
                }
            }
            Spacer()
            
            Button {
                vm.isPresentAddTrainingChoose = false
            } label: {
                RedButtonView(text: "Save")
            }

        }.padding()
    }
}

#Preview {
    TrainingForHistoryView(vm: HomeViewModel())
}
