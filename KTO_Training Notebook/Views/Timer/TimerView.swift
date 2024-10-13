

import SwiftUI
import CoreData

struct TimerView: View {
    @StateObject var vm = TimerViewModel()

    var body: some View {

        ZStack {
            VStack {
                TimerCircleManualView(totalTime: vm.totalManualTime(), timeLeft: vm.manualTimeLeft)
                    .frame(width: 300, height: 300)
                    .padding()
                // Ввод времени вручную
                TimerTimeView(hours: $vm.manualHours, minutes: $vm.manualMinutes, seconds: $vm.manualSeconds)
                
                // Кнопка для запуска ручного таймера
                if vm.isManualTimerRunning{
                    HStack{
                        Button {
                            vm.startManualTimer()
                        } label: {
                            ZStack {
                                Color.white.opacity(0.05).cornerRadius(12)
                                Text("Again")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 17, weight: .bold))
                            }.frame(height: 50)
                        }
                        Button {
                            vm.stopManualTimer()
                        } label: {
                            RedButtonView(text: "Stop")
                        }
                        
                    }
                }else{
                    Button(action: {
                        if vm.isManualTimerRunning {
                            vm.stopManualTimer()
                        } else {
                            vm.startManualTimer()
                        }
                    }) {
                        RedButtonView(text: "Go")
                    }
                }
                
                
                
                Divider()
                
                // Список таймеров из Core Data
                VStack {
                    HStack{
                        Text("Personal timers")
                            .font(.title2)
                        Spacer()
                        
                        //MARK: - Add timer button
                        Button {
                            vm.isAddingTimer = true
                        } label: {
                            Text("Add")
                                .padding(8)
                                .background(Color.brownApp.cornerRadius(12))
                        }
                    }
                    ScrollView {
                        ForEach(vm.timers) { timer in
                            TimerCellView(timer: timer, vm: vm)
                                .onTapGesture {
                                    vm.tapSaveTimer(timer: timer)
                                    vm.selectedTimer = timer
                                }
                        }
                    }
                }
                .navigationTitle("Timers")
                
                //                    .sheet(isPresented: $vm.isAddingTimer) {
                //                        addTimerSheet
                //                    }
            }.padding()
            if vm.isAddingTimer {
                addTimerSheet
            }
                
        }
        .animation(.bouncy, value: vm.isAddingTimer)
            }
        
    private var addTimerSheet: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.7)
                .onTapGesture {
                    vm.isAddingTimer = false
                }
            VStack {
                //Spacer()
                VStack(alignment: .leading){
                    Text("Name")
                        
                    TextField("Text", text: $vm.simplrNameTimer)
                        .padding()
                        .background(Color.white.opacity(0.05).cornerRadius(12))
                    HStack {
                        Text("Hours")
                            .font(.system(size: 13))
                        TextField("0", text: $vm.simpleHoursTimer)
                            .padding()
                            .background(Color.white.opacity(0.05).cornerRadius(12))
                        
                        Text("Minutes")
                            .font(.system(size: 13))
                        TextField("0", text: $vm.simpleMinutesTimer)
                            .padding()
                            .background(Color.white.opacity(0.05).cornerRadius(12))
                        
                        Text("Seconds")
                            .font(.system(size: 13))
                        TextField("0", text: $vm.simpleSecondsTimer)
                            .padding()
                            .background(Color.white.opacity(0.05).cornerRadius(12))
                    }
                }
                
                Button("Сохранить") {
                    vm.addTimer()
                    vm.isAddingTimer = false
                }
            }.padding()
            .background {
                Color.black.cornerRadius(12)
            }
        }
    }
    }
  
#Preview {
    TimerView()
}

   
    
    
    
    
   



