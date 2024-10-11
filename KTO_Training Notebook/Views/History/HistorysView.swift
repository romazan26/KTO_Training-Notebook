//
//  HistorysView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//

import SwiftUI

struct HistorysView: View {
    @StateObject var vm: HomeViewModel
    var body: some View {
        VStack(spacing: 20) {
            //MARK: - History count
            VStack {
                Text("\(vm.historys.count)")
                    .font(.title)
                Text("training sessions were conducted")
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(content: {
                Color.brownApp.cornerRadius(12)
            })
            ScrollView {
                if vm.historys.isEmpty {
                    EmptryEntryView()
                }else{
                    ForEach(vm.historys) { history in
                        NavigationLink {
                            HistoryView(history: history, vm: vm)
                        } label: {
                            HistoryCellView(history: history)
                        }

                       
                    }
                }
               
            }
        
        }
        //MARK: - Add button
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddHistoryView(vm: vm)
                    } label: {
                        Text("Add")
                            .padding(8)
                            .background(Color.brownApp.cornerRadius(12))
                    }
                }
            }
        .navigationTitle("Training history")
        .padding()
    }
}

#Preview {
    NavigationView {
        HistorysView(vm: HomeViewModel())
    }
}
