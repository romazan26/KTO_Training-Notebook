//
//  TrainingsView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 10.10.2024.
//

import SwiftUI

struct TrainingsView: View {
    @StateObject var vm : HomeViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            //MARK: - Training count
            VStack {
                Text("\(vm.trainings.count)")
                    .font(.title)
                Text("exercises added")
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(content: {
                Color.brownApp.cornerRadius(12)
            })
            //MARK: - Traininf list
            if vm.trainings.isEmpty {
                EmptyView()
            }else{
                ScrollView {
                    ForEach(vm.trainings) { training in
                        NavigationLink {
                            TrainingView(vm: vm, training: training)
                        } label: {
                            TrainingCellView(training: training)
                        }  
                    }
                }
            }
            
            
            Spacer()
            
        }
        //MARK: - Add button
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddTrainingView(vm: vm)
                    } label: {
                        Text("Add")
                            .padding(8)
                            .background(Color.brownApp.cornerRadius(12))
                    }
                }
            }
        .navigationTitle("Training")
        .padding()
    }
}

#Preview {
    NavigationView {
        TrainingsView(vm: HomeViewModel())
    }
}
