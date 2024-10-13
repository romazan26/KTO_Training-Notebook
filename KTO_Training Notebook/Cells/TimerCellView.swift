//
//  TimerCellView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 12.10.2024.
//

import SwiftUI

struct TimerCellView: View {
    @ObservedObject var timer: TimerEntity
    @StateObject var vm: TimerViewModel
    var body: some View {
        HStack {
            Text(timer.name ?? "")
                .font(.system(size: 17))
            Spacer()
            Text("\(formatTime(timer: timer))")
                .padding(10)
                .background {
                    Color(vm.selectedTimer == timer ? .red : .white)
                        .opacity(vm.selectedTimer == timer ? 1 : 0.05)
                        .cornerRadius(12)
                }
        }
        .padding()
        .background {
            Color(vm.selectedTimer == timer ? .brownApp : .white)
                .cornerRadius(12)
                .opacity(vm.selectedTimer == timer ? 1 : 0.05)
        }
    }
    func formatTime(timer: TimerEntity) -> String {
        // Форматирует часы, минуты, секунды в формате "чч:мм:сс"
        String(format: "%02d:%02d:%02d", timer.hours, timer.minutes, timer.seconds)
    }
}

#Preview {
    TimerCellView(timer: TimerEntity(), vm: TimerViewModel())
}
