//
//  SettingButton.swift
//  KTO_Training Notebook
//
//  Created by Роман on 13.10.2024.
//

import SwiftUI

struct SettingButton: View {
    var text = ""
    var body: some View {
        ZStack {
            Color(.white)
                .opacity(0.05)
                .cornerRadius(24)
                
            HStack {
                Text(text)
                Spacer()
                Image(systemName: "arrow.up.right.circle.fill")
                    .resizable()
                    .frame(width: 34, height: 34)
                    .foregroundStyle(.red)
                
            }
            .padding(.horizontal, 35)
            .foregroundStyle(.white)
            .font(.system(size: 15, weight: .heavy))
        }
        .frame(width: 358, height: 66)
    }
}

#Preview {
    SettingButton()
}
