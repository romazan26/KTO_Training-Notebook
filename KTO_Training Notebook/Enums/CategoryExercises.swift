//
//  CategoryExercises.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//
import Foundation

enum CategoryExercises: String, CaseIterable, Identifiable {
    var id: Self { self }
    case cardio = "cardio"
    case strength = "strength"
    case flexibility = "flexibility"
    case balance = "balance"
    case yoga = "yoga"
    case power = "power"
}
