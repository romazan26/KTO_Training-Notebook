//
//  TrainingCellView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//

import SwiftUI

struct TrainingCellView: View {
    @ObservedObject var training: Training
    @State var arrayCategory: [Category] = []
    @State var arrayImage: [UIImage] = []
    var body: some View {
        ZStack(alignment: .leading) {
            Color.brownApp.cornerRadius(12)
            VStack(alignment: .leading) {
                
                //MARK: - Title training
                Text(training.title ?? "")
                    .font(.title2)
                    .foregroundStyle(.white)
                
                //MARK: - Categoryes
                HStack{
                    ForEach(arrayCategory) { category in
                        Text(category.nameCategory ?? "")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .background {
                                Color.white.opacity(0.05)
                                    .cornerRadius(12)
                            }
                    }
                }
                
                //MARK: - Exercises images
        
                HStack(spacing: 0) {
                    let maxVisibleImages = 3 // Максимальное количество видимых изображений
                    
                    // Получаем подмассив первых трех элементов
                    let visibleImages = Array(arrayImage.prefix(maxVisibleImages))
                    
                    // Показываем первые три изображения
                    ForEach(Array(visibleImages.enumerated()), id: \.element) { index, image in
                       
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 32, height: 32)
                                .cornerRadius(16)
                                .offset(x: CGFloat(index) * -9.6) // Сдвигаем на 30% от ширины
                                .zIndex(Double(visibleImages.count - index)) // Управляем наложением
                        
                    }
                    
                    // Если элементов больше, чем 3, добавляем кружок с количеством оставшихся элементов
                    if arrayImage.count > maxVisibleImages {
                        let remainingCount = arrayImage.count - maxVisibleImages
                        
                        Text("+\(remainingCount)")
                            .font(.system(size: 12))
                            .frame(width: 32, height: 32)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .offset(x: CGFloat(maxVisibleImages) * -9.6) // Сдвиг для последнего элемента
                            .zIndex(Double(0)) // Поставить поверх других
                    }
                }
                  
                
                
                //MARK: - Training discription
                Text(training.descript ?? "")
                    .font(.system(size: 15))
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding()
        }
        .onAppear {
            getArrayCategory(training: training)
        }
        .frame(height: 223)
    }
    func getArrayCategory(training: Training){
        arrayCategory = []
        arrayImage = []
        if let exercises = training.exercises?.allObjects as? [Exercises] {
            for exercise in exercises {
                if let image = exercise.image {
                    arrayImage.append(image)
                }
                if let categoryes = exercise.category?.allObjects as? [Category] {
                    for category in categoryes {
                        arrayCategory.append(category)
                    }
                }
            }
        }
    }
    
}

//#Preview {
//    TrainingCellView(training: Training())
//}
