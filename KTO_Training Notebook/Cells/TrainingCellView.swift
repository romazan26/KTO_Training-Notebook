//
//  TrainingCellView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//

import SwiftUI

struct TrainingCellView: View {
    @ObservedObject var training: Training
    var body: some View {
        ZStack(alignment: .leading) {
            Color.brownApp.cornerRadius(12)
            VStack(alignment: .leading) {
                Text(training.title ?? "")
                    .font(.title3)
                if let exercises = training.exercises?.allObjects as? [Exercises] {
                    
                        ForEach(exercises) { exercise in
                            HStack{
                                if let categoryes = exercise.category?.allObjects as? [Category] {
                                    ForEach(categoryes) { category in
                                        Text(category.nameCategory ?? "")
                                            .foregroundStyle(.gray)
                                            .padding(10)
                                            .background {
                                                Color.white.opacity(0.05)
                                                    .cornerRadius(12)
                                            }
                                    }
                                }
                        }
                            HStack{
                                if let image = exercise.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .cornerRadius(50)
                                }
                            }
                        
                    }
                }
                Text(training.descript ?? "")
            }
            .padding()
        }.frame(height: 223)
    }
}

//#Preview {
//    TrainingCellView(training: Training())
//}
