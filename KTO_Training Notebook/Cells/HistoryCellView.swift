//
//  HistoryCellView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//

import SwiftUI

struct HistoryCellView: View {
    let history: History
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10) {
                Text(history.title ?? "")
                    .foregroundStyle(.white)
                    .font(.title2)
                if let training = history.training?.allObjects as? [Training] {
                    Text(training.first!.title ?? "")
                        .foregroundStyle(.gray)
                }
                    
                
                HStack {
                    Image(systemName: "calendar").foregroundStyle(.red)
                    Text(Dateformatter(date: history.date ?? Date()))
                        .foregroundStyle(.gray)
                    Image(systemName: "clock").foregroundStyle(.red)
                    Text("\(history.beginning ?? "") - \(history.ending ?? "") PM")
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
            Image(systemName: "arrow.up.right.circle.fill")
                .resizable()
                .frame(width: 34, height: 34)
                .foregroundStyle(.red)
        }
        .padding()
        .frame(height: 110)
        .background {
            Color.brownApp.cornerRadius(12)
        }
    }
    //MARK: - Dateformatter
    private func Dateformatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M.yyyy"
        return dateFormatter.string(from: date)
    }
}

//#Preview {
//    HistoryCellView(history: History())
//}
