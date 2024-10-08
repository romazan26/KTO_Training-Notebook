//
//  LoadingViewModel.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

final class LoadingViewModel: ObservableObject {
    @Published var timeLoading: Int = 0
    @Published var isPresent: Bool = false
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool?
}
