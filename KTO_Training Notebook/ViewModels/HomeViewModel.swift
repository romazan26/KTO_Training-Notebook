//
//  HomeViewModel.swift
//  KTO_Training Notebook
//
//  Created by Роман on 10.10.2024.
//

import CoreData
import SwiftUI
import PhotosUI

final class HomeViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var exercises: [Exercises] = []
    @Published var categories: [Category] = []
    @Published var simpleExerciseTitle: String = ""
    @Published var simpleDescriptExercises: String = ""
    @Published var simpleImage: UIImage? = UIImage(resource: .noExercises)
    @Published var simpleCategory: CategoryExercises?
    @Published var arrayCategory: [String] = []
    @Published var categotyCount: Int = 0
    @Published var isPresentPicker: Bool = false
    @Published var sortExercises: [Exercises] = []
    
    var config: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        return config
    }
    
    init(){
        getcategory()
        getExercises()
    }
    
    //MARK: - Sorting Exercises
    func sorting(){
        sortExercises = []
        getExercises()
        if simpleCategory == nil{
            sortExercises = exercises
        }
        for exercise in exercises {
            if let categorys = exercise.category?.allObjects as? [Category]{
                for category in categorys {
                    if category.nameCategory == simpleCategory?.rawValue {
                        sortExercises.append(exercise)
                    }
                }
            }
        }
    }
    
    //MARK: - Clear data
    func clear(){
        simpleExerciseTitle = ""
        simpleDescriptExercises = ""
        simpleImage = UIImage(resource: .noExercises)
        simpleCategory = .balance
        arrayCategory = []
        categotyCount = 0
    }
    
    //MARK: - add Data
    func addExercise(){
        let exercise = Exercises(context: manager.context)
        exercise.titleExercises = simpleExerciseTitle
        exercise.descript = simpleDescriptExercises
        exercise.image = simpleImage
        for category in arrayCategory {
            addOneCategory(exercise: exercise, categoryName: category)
        }
        manager.save()
        clear()
    }
    
    func addOneCategory(exercise: Exercises, categoryName: String){
        let category = Category(context: manager.context)
        category.nameCategory = categoryName
        category.exercises = exercise
        manager.save()
    }
    
    func omeMoreCategory(){
        arrayCategory.append(simpleCategory?.rawValue ?? CategoryExercises.balance.rawValue)
        categotyCount += 1
    }
    
    //MARK: - Save data
    func saveExercise(){
        exercises.removeAll()
        categories.removeAll()
        manager.save()
        getExercises()
        getcategory()
    }
    
    //MARK: - Get data
    func getExercises() {
        let request = NSFetchRequest<Exercises>(entityName: "Exercises")
        do{
            exercises = try manager.context.fetch(request)
        }catch let error{
            print(error)
        }
    }
    func getcategory() {
        let request = NSFetchRequest<Category>(entityName: "Category")
        do{
            categories = try manager.context.fetch(request)
        }catch let error{
            print(error)
        }
    }
    
}
