//
//  ExercisesCellView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 10.10.2024.
//

import SwiftUI

struct ExercisesCellView: View {
    @ObservedObject var exercese: Exercises
    var body: some View {
        HStack {
            if let image = exercese.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
            }
            VStack(alignment: .leading) {
                Text(exercese.titleExercises ?? "")
                    .font(.title)
                if let categorys = exercese.category?.allObjects as? [Category] {
                    HStack {
                        ForEach(categorys) { category in
                            Text(category.nameCategory ?? "")
                                .foregroundStyle(.gray)
                                .padding(8)
                                .background {
                                    Color.white.opacity(0.05).cornerRadius(12)
                                }
                        }
                    }
                }
            }
            
            Spacer()
            Image(systemName: "arrow.up.right.circle.fill")
                .resizable()
                .frame(width: 34, height: 34)
                .foregroundStyle(.red)
        }
    }
}

//#Preview {
//    ExercisesCellView(exercese: Exercises())
//}
