//
//  HistorysView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//

import SwiftUI

struct HistorysView: View {
    var body: some View {
        VStack(spacing: 20) {
            //MARK: - History count
            VStack {
                Text("0")
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
                EmptryEntryView()
            }
        
        }
        //MARK: - Add button
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        //AddTrainingView(vm: vm)
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
        HistorysView()
    }
}
