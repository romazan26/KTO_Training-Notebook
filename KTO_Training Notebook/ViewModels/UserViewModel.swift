//
//  UserViewModel.swift
//  KTO_Training Notebook
//
//  Created by Роман on 13.10.2024.
//

import SwiftUI
import UIKit

final class UserViewModel: ObservableObject {
    @AppStorage("weight") var weightStorage: String?
    @AppStorage("age") var ageStorage: String?
    @AppStorage("height") var heightStorage: String?
    @AppStorage("fat") var fatStorage: String?
    
    @Published var weight: String = ""
    @Published var age: String = ""
    @Published var height: String = ""
    @Published var fat: String = ""
    
    init(){
        weight = weightStorage ?? ""
        age = ageStorage ?? ""
        height = heightStorage ?? ""
        fat = fatStorage ?? ""
    }
    
    func save(){
        weightStorage = weight
        ageStorage = age
        heightStorage = height
        fatStorage = fat
    }
}
