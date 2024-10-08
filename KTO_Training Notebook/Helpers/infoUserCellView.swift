//
//  infoUserCellView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct infoUserCellView: View {
    var textTop: String
    var textBottom: String
    var image: ImageResource
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 32, height: 32)
            VStack(alignment: .leading) {
                Text(textTop)
                    .font(.system(size: 13, weight: .heavy))
                Text(textBottom)
                    .foregroundStyle(.gray)
                    .font(.system(size: 11))
                        
            }
        }
    }
}

#Preview {
    infoUserCellView(textTop: "85 kg", textBottom: "Weight", image: .weight)
}
