//
//  Untitled.swift
//  KTO_Training Notebook
//
//  Created by Роман on 13.10.2024.
//

import SwiftUI

struct TimerTimeView: View {
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    enum timetSelector {
        case hours
        case minutes
        case seconds
    }
    @State private var selector: timetSelector = .hours
    
    var body: some View {
        HStack(spacing: 1) {
            Button(action: {
                switch selector {
                case .hours: if hours > 0 { hours -= 1 }
                case .minutes: if minutes > 0 { minutes -= 1 }
                case .seconds: if seconds > 0 { seconds -= 1 }
                }
                
            }) {Image(systemName: "minus.circle")}
                .padding(.horizontal)
            Text(String(format: "%02d:", hours))
                .onTapGesture {selector = .hours}
                .foregroundStyle(selector == .hours ? .red : .white)
            
            Text(String(format: "%02d:",minutes))
                .onTapGesture {selector = .minutes}
                .foregroundStyle(selector == .minutes ? .red : .white)
            
            Text(String(format: "%02d",seconds))
                .onTapGesture {selector = .seconds}
                .foregroundStyle(selector == .seconds ? .red : .white)
            
            Button(action: {
                switch selector {
                case .hours:  hours += 1
                case .minutes:  minutes += 1
                case .seconds:  seconds += 1
                }
                
            }) {Image(systemName: "plus.circle")}
                .padding(.horizontal)
        }
    }
}

//#Preview {
//    TimerTimeView()
//}
