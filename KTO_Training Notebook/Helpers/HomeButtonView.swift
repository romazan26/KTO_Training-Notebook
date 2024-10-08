//
//  HomeButtonView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct HomeButtonView: View {
    var imageName: String
    var body: some View {
        ZStack {
            Color.red.cornerRadius(12)
            Image(systemName: imageName)
                .resizable()
                .frame(width: 24, height: 24)
        }.frame(height: 48)
    }
}

#Preview {
    HomeButtonView(imageName: "doc.richtext.fill")
}
