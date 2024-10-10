//
//  ExercisesMiniCellView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 10.10.2024.
//

import SwiftUI

struct ExercisesMiniCellView: View {
    @ObservedObject var exercises: Exercises
    var body: some View {
        HStack {
            Text(exercises.titleExercises ?? "")
                .font(.title3)
            if let categorys = exercises.category?.allObjects as? [Category]{
                Text(categorys.first?.nameCategory ?? "")
                    .foregroundStyle(.gray)
                    .padding(8)
                    .background {
                        Color.white.opacity(0.05)
                            .cornerRadius(12)
                    }
            }
        }
        .padding()
        .background {
            Color.brownApp.cornerRadius(12)
        }
    }
}

#Preview {
    ExercisesMiniCellView(exercises: Exercises())
}
