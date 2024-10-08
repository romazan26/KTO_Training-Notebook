//
//  EmptryEntryView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct EmptryEntryView: View {
    var body: some View {
        ZStack {
            Color.brownApp.cornerRadius(12)
            VStack {
                Image(.star)
                    .resizable()
                    .frame(width: 60, height: 60)
                Text("Empty")
                    .font(.system(size: 28, weight: .heavy))
                Text("You haven't added any entries")
                    .foregroundStyle(.gray)
            }
        }
        .frame(height: 168)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    EmptryEntryView()
}
