//
//  TimerCircleView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 12.10.2024.
//
import SwiftUI

struct TimerCircleView: View {
    @ObservedObject var timer: TimerEntity

    var totalSeconds: Int {
        return Int(timer.hours * 3600 + timer.minutes * 60 + timer.seconds)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.gray.opacity(0.3))
                
                Circle()
                    .trim(from: 0, to: CGFloat(totalSeconds) / CGFloat(initialTotalTime(timer: timer)))
                    .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90)) // Начинаем с верхней точки
                    .animation(.linear(duration: 1), value: totalSeconds)

                Text("\(formatTime(timer: timer))")
                    .font(.title)
                    .bold()
            }
        }
    }
    
    func initialTotalTime(timer: TimerEntity) -> Int {
        // Общий начальный тайминг (часы, минуты, секунды) в секундах
        return Int(timer.hours * 3600 + timer.minutes * 60 + timer.seconds)
    }
    
    func formatTime(timer: TimerEntity) -> String {
        // Форматирует часы, минуты, секунды в формате "чч:мм:сс"
        String(format: "%02d:%02d:%02d", timer.hours, timer.minutes, timer.seconds)
    }
}
