//
//  UserInfoView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct UserInfoView: View {
    var body: some View {
        HStack(alignment: .center) {
           
            //MARK: - User image
            ZStack(alignment: .bottomTrailing) {
                Image(.userTest)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image(systemName: "pencil")
                    .padding(4)
                    .foregroundStyle(.red)
            }.frame(width: 76, height: 76)
            
            LazyVGrid(columns: [GridItem(.flexible(minimum: 100)), GridItem(.flexible(minimum: 100))],alignment: .leading) {
                infoUserCellView(textTop: "85 kg", textBottom: "Weight", image: .weight)
                infoUserCellView(textTop: "178", textBottom: "wake up", image: .wakeUp)
                infoUserCellView(textTop: "21", textBottom: "Age", image: .age)
                infoUserCellView(textTop: "40 %", textBottom: "% of flat", image: .ofFlat)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            Color.brownApp.cornerRadius(16)
        }
    }
}

#Preview {
    UserInfoView()
}
