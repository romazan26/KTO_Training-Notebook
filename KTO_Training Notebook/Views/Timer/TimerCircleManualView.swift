//
//  TimerCircleManualView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//
import SwiftUI

struct TimerCircleManualView: View {
    var totalTime: Int
    var timeLeft: Int

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.gray.opacity(0.3))
                
                Circle()
                    .trim(from: 0, to: CGFloat(timeLeft) / CGFloat(totalTime))
                    .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90)) // Начинаем с верхней точки
                    .animation(.linear(duration: 1), value: timeLeft)

                Text(formatTime(seconds: timeLeft))
                    .font(.title)
                    .bold()
            }
        }
    }
    
    func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }
}
