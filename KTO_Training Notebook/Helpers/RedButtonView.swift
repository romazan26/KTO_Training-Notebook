//
//  RedButtonView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct RedButtonView: View {
    var text: String = "Save"
    var body: some View {
        ZStack {
            Color.red.cornerRadius(12)
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 17, weight: .bold))
        }.frame(height: 50)
    }
}

#Preview {
    RedButtonView()
}
