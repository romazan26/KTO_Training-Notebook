//
//  HistoryView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    @StateObject var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            //MARK: - Calendar
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(.red)
                Text(Dateformatter(date: history.date ?? Date()))
                    .foregroundStyle(.gray)
                Image(systemName: "clock")
                    .foregroundStyle(.red)
                Text("\(history.beginning ?? "") - \(history.ending ?? "") PM")
                    .foregroundStyle(.gray)
                Spacer()
            }
            .padding()
            .background { Color.brownApp.cornerRadius(12)}
            
            //MARK: - training
            if let training = history.training?.allObjects as? [Training] {
                TrainingCellView(training: training.first!)
            }
            Spacer()
            
            //MAK: - Delete buttom
            Button {
                vm.deleteHistory(history)
                dismiss()
            } label: {
                RedButtonView(text: "Delete")
            }

        }
        .padding()
        .navigationTitle(history.title ?? "")
    }
    //MARK: - Dateformatter
    private func Dateformatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M.yyyy"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    HistoryView(history: History(), vm: HomeViewModel())
}
