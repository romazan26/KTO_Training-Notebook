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
    
    //MARK: - Home Propertys
    @Published var isPresentSetting: Bool = false
    @Published var ispresentUser: Bool = false
    
    //MARK: - Exercises propertyes
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
    
    //MARK: - Training Propertes
    @Published var trainings: [Training] = []
    @Published var simpleTraining: Training?
    @Published var simpleTrainingTitle: String = ""
    @Published var simpleTrainingDescript: String = ""
    @Published var arrayExercises: [Exercises] = []
    @Published var isPresentAddExercises = false
    @Published var isPresentEditTraining: Bool = false
    
    //MARK: - History propertyes
    @Published var historys: [History] = []
    @Published var simpleHistory: History?
    @Published var simpleHistoryTitle: String = ""
    @Published var simpleHistoryDate: Date = Date()
    @Published var simpleHistoryBegining: String = ""
    @Published var simpleHistoryEnding: String = ""
    @Published var isPresentEditHistory: Bool = false
    @Published var isPresentAddTrainingChoose: Bool = false
//    @Published var arrayTraining: [Training] = []
    @Published var simpleTrainingChoose: Training?
    
    init(){
        getcategory()
        getExercises()
        gettraining()
        getHistory()
    }
    
    //MARK: - Edit data
    
    func editTraining(){
        let request = NSFetchRequest<Training>(entityName: "Training")
        do{
            trainings = try manager.context.fetch(request)
            let training = trainings.first(where: {$0.id == simpleTraining?.id})
            training?.title = simpleTrainingTitle
            training?.descript = simpleTrainingDescript
            if let exercises = training?.exercises?.allObjects as? [Exercises]{
                for exercise in exercises {
                    exercise.training = nil
                }
                for exercise in arrayExercises{
                    addOneExecise(training: training!, exercise: exercise)
                }
            }
            
        }catch let error{
            print(error)
        }
        saveTraining()
        clearTraining()
        isEditModel = false
        isPresentEditTraining = false
    }
    
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
    func fiilTraining(training: Training){
        clearTraining()
        simpleTraining = training
        simpleTrainingTitle = training.title ?? ""
        simpleTrainingDescript = training.descript ?? ""
        if let exercises = training.exercises?.allObjects as? [Exercises]{
            for exercise in exercises {
                arrayExercises.append(exercise)
            }
        }
    }
    
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
    func deleteHistory(_ history: History){
        manager.context.delete(history)
        saveHistory()
    }
    
    func deleteTraining(_ training: Training){
        manager.context.delete(training)
        saveTraining()
    }
    
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
    func clearHistory(){
        simpleHistoryTitle = ""
        simpleHistoryDate = Date()
        simpleHistoryBegining = ""
        simpleHistoryEnding = ""
        simpleTrainingChoose = nil
    }
    
    func clearTraining(){
        simpleTrainingTitle = ""
        simpleTrainingDescript = ""
        arrayExercises = []
    }
    
    func clear(){
        simpleExerciseTitle = ""
        simpleDescriptExercises = ""
        simpleImage = UIImage(resource: .noExercises)
        simpleCategory = .all
        arrayCategory = []
        categotyCount = 0
    }
    
    //MARK: - add Data
    
    func addHistory(){
        let history = History(context: manager.context)
        history.title = simpleHistoryTitle
        history.date = simpleHistoryDate
        history.beginning = simpleHistoryBegining
        history.ending = simpleHistoryEnding
        simpleTrainingChoose?.addToHistory(history)
        saveTraining()
        saveHistory()
        clearHistory()
    }
  
    
    func oneMoreExercise(execise: Exercises){
        if let index = arrayExercises.firstIndex(of: execise) {
            arrayExercises.remove(at: index)
        } else {
            arrayExercises.append(execise)
        }
        
    }
    
    func addTraining(){
        let training = Training(context: manager.context)
        training.title = simpleTrainingTitle
        training.descript = simpleTrainingDescript
        for exercise in arrayExercises {
            addOneExecise(training: training, exercise: exercise)
        }
        saveTraining()
        clearTraining()
    }
    
    func addOneExecise(training: Training, exercise: Exercises){
        training.addToExercises(exercise)
        saveExercise()
    }
    
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
    func saveHistory(){
        historys.removeAll()
        manager.save()
        getHistory()
    }
    
    func saveExercise(){
        exercises.removeAll()
        categories.removeAll()
        manager.save()
        getExercises()
        getcategory()
    }
    func saveTraining(){
        trainings.removeAll()
        manager.save()
        gettraining()
    }
    
    //MARK: - Get data
    func getHistory() {
        let request = NSFetchRequest<History>(entityName: "History")
        do{
            historys = try manager.context.fetch(request)
        }catch let error{
            print(error)
        }
    }
    
    func gettraining() {
        let request = NSFetchRequest<Training>(entityName: "Training")
        do{
            trainings = try manager.context.fetch(request)
        }catch let error{
            print(error)
        }
    }
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
