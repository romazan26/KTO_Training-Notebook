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
    @Published var simpleExercise: Exercises?
    @Published var categories: [Category] = []
    @Published var simpleExerciseTitle: String = ""
    @Published var simpleDescriptExercises: String = ""
    @Published var simpleImage: UIImage? = UIImage(resource: .noExercises)
    @Published var simpleCategory: CategoryExercises = .all
    @Published var arrayCategory: [String] = []
    @Published var categotyCount: Int = 0
    @Published var isPresentPicker: Bool = false
    @Published var sortExercises: [Exercises] = []
    @Published var isEditModel: Bool = false
    @Published var isPresentEditExercise: Bool = false
    
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
    
    //MARK: - Edit data
    func editExercise(){
        let request = NSFetchRequest<Exercises>(entityName: "Exercises")
        do{
            exercises = try manager.context.fetch(request)
            let exercise = exercises.first(where: {$0.id == simpleExercise?.id})
            exercise?.titleExercises = simpleExerciseTitle
            exercise?.descript = simpleDescriptExercises
            exercise?.image = simpleImage
            if let categorys = exercise?.category?.allObjects as? [Category]{
                for category in categorys {
                    manager.context.delete(category)
                }
            }
           // manager.save()
            for category in arrayCategory {
                addOneCategory(exercise: exercise!, categoryName: category)
            }
        }catch let error{
            print(error)
        }
        saveExercise()
        clear()
        isEditModel = false
        isPresentEditExercise = false
    }
    
    //MARK: - Fill data
    func fillexercises(exercise: Exercises){
        clear()
        simpleExercise = exercise
        simpleExerciseTitle = exercise.titleExercises ?? ""
        simpleImage = exercise.image
        simpleDescriptExercises = exercise.descript ?? ""
        if let categorys = exercise.category?.allObjects as? [Category]{
            for category in categorys {
                arrayCategory.append(category.nameCategory ?? "")
            }
        }
    }
    
    //MARK: - Delete data
    func deleteExercise(_ exercise: Exercises){
        if let categorys = exercise.category?.allObjects as? [Category]{
            for category in categorys {
                manager.context.delete(category)
            }
        }
        manager.context.delete(exercise)
        saveExercise()
    }
    
    //MARK: - Sorting Exercises
    func sorting(){
        sortExercises = []
        getExercises()
        if simpleCategory.rawValue == "all"{
            sortExercises = exercises
        }else{
            for exercise in exercises {
                if let categorys = exercise.category?.allObjects as? [Category]{
                    for category in categorys {
                        if category.nameCategory == simpleCategory.rawValue {
                            sortExercises.append(exercise)
                        }
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
        simpleCategory = .all
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
        saveExercise()
        clear()
    }
    
    func addOneCategory(exercise: Exercises, categoryName: String){
        let category = Category(context: manager.context)
        category.nameCategory = categoryName
        category.exercises = exercise
        manager.save()
    }
    
    func omeMoreCategory(){
        arrayCategory.append(simpleCategory.rawValue)
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
