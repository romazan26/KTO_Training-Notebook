//
//  ContentView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 08.10.2024.
//

import SwiftUI

struct LoadingView: View {
    @StateObject var vm = LoadingViewModel()
    
    var body: some View {
        ZStack {
            Image(.logo)
                .resizable()
                .frame(width: 200, height: 200)
            ProgressView()
                .padding(.top, 500)
            
        }
        .fullScreenCover(isPresented: $vm.isPresent, content: {
            if vm.isFirstLaunch ?? true {
                IntroView()
            }else{
               // MainView()
            }
        })
        .onAppear(perform: {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if vm.timeLoading < 50{
                    vm.timeLoading += 1
                }else {
                    timer.invalidate()
                    vm.isPresent = true
                }
            }
        })
        .padding()
    }
}

#Preview {
    LoadingView()
}
