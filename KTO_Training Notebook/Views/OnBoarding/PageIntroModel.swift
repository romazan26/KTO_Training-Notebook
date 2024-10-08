//
//  PageIntroModel.swift
//  AircraftInspection
//
//  Created by Роман on 05.04.2024.
//

import Foundation

struct PageIntro: Identifiable,Equatable {
    let id = UUID()
    var imageUrl: String
    var text: String
    var tag: Int

    static var samplePage = PageIntro(imageUrl: "intro1", text: "All the training is in your hands", tag: 0)
    
    static var sampalePages: [PageIntro] = [
        PageIntro(imageUrl: "intro1", text: "All the training is in your hands", tag: 0),
        PageIntro(imageUrl: "intro2", text: "Control the process with one touch", tag: 1),
    ]
}
