//
//  TimerViewModel.swift
//  KTO_Training Notebook
//
//  Created by Роман on 11.10.2024.
//

import CoreData

final class TimerViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var timers: [TimerEntity] = []
    @Published var selectedTimer: TimerEntity?
    @Published var simplrNameTimer: String = ""
    @Published var simpleSecondsTimer: String = ""
    @Published var simpleMinutesTimer: String = ""
    @Published var simpleHoursTimer: String = ""
    @Published var isAddingTimer = false
    
    // Состояния для ручного таймера
    @Published  var manualHours = 0
    @Published  var manualMinutes = 0
    @Published  var manualSeconds = 0
    @Published  var isManualTimerRunning = false
    @Published  var manualTimer: Timer? = nil
    @Published  var manualTimeLeft: Int = 0
    
    var timer: Timer? = nil
    
    init() {
        getTimers()
    }
    
    func tapSaveTimer(timer: TimerEntity){
        manualHours = Int(timer.hours)
        manualMinutes = Int(timer.minutes)
        manualSeconds = Int(timer.seconds)
    }
    
    // Логика обратного отсчета для таймеров из базы данных
    func startCountdown(for timer: TimerEntity) {
        if timer.isRuning {
            stopCountdown(for: timer)
        } else {
            timer.isRuning = true
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.countdownTick(for: timer)
            }
        }
    }
    
     func stopCountdown(for timer: TimerEntity) {
        timer.isRuning = false
        self.timer?.invalidate()
        self.timer = nil
    }
    
     func countdownTick(for timer: TimerEntity) {
        if timer.seconds > 0 {
            timer.seconds -= 1
        } else if timer.minutes > 0 {
            timer.minutes -= 1
            timer.seconds = 59
        } else if timer.hours > 0 {
            timer.hours -= 1
            timer.minutes = 59
            timer.seconds = 59
        } else {
            stopCountdown(for: timer)
        }
    }
    
    // Логика ручного таймера
     func startManualTimer() {
        manualTimeLeft = totalManualTime()
        isManualTimerRunning = true
        manualTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.manualTimeLeft > 0 {
                self.manualTimeLeft -= 1
            } else {
                self.stopManualTimer()
            }
        }
    }
    
     func stopManualTimer() {
        isManualTimerRunning = false
        manualTimer?.invalidate()
        manualTimer = nil
    }
    
     func totalManualTime() -> Int {
        return manualHours * 3600 + manualMinutes * 60 + manualSeconds
    }
    
    //MARK: - Clear data
    func clearTimer() {
        simplrNameTimer = ""
        simpleSecondsTimer = ""
        simpleMinutesTimer = ""
        simpleHoursTimer = ""
    }
    
    //MARK: - Add data
    func addTimer() {
        let newTimer = TimerEntity(context: manager.context)
        newTimer.name = simplrNameTimer
        newTimer.seconds = Int16(simpleSecondsTimer) ?? 0
        newTimer.minutes = Int16(simpleMinutesTimer) ?? 0
        newTimer.hours = Int16(simpleHoursTimer) ?? 0
        newTimer.isRuning = false
        saveTimer()
        clearTimer()
        print("Timer added")
    }
    
    //MARK: - Save data
    func saveTimer() {
        timers.removeAll()
        manager.save()
        getTimers()
    }
    
    //MARK: - Get data
    func getTimers() {
        let request = NSFetchRequest<TimerEntity>(entityName: "TimerEntity")
        do{
            timers = try manager.context.fetch(request)
        }catch let error{
            print(error)
        }
        
    }
}
