//
//  ContentView.swift
//  race-stopwatch
//
//  Created by Trevor Cash on 4/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var distance: Double? = 5000
    @State private var splitDistance: Double? = 1600
    @State private var unit : String = "m"
    @State private var runners: [Runner] = [Runner(name:"Trevor")]
    @State private var editSettings = false
    @State private var currentTime: TimeInterval = 0
    @State private var startTime: TimeInterval = 0
    @State private var isRunning: Bool = false;
    @State private var timer: Timer?
    func startTimer(){
        isRunning = true
        let startDate:Date = .now
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            currentTime = startDate.timeIntervalSinceNow * -1 + startTime
        }
    }
    func stopTimer(){
        timer?.invalidate()
        startTime = currentTime;
        isRunning = false
    }
    func resetTimer(){
        startTime = 0
        currentTime = 0
    }
    func lapTimer(){
        
    }
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let tenths = Int((time * 10).truncatingRemainder(dividingBy: 10))
        return String(format: "%02d:%02d.%d", minutes, seconds, tenths)
    }
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button("Edit Settings", systemImage: "plus"){
                    editSettings = true
                }
                .padding(.trailing)
            }
            Spacer()
            Text(formatTime(currentTime)).font(.system(size: 75)).fontDesign(.monospaced)
            Text("Estimated 5000m time is:")
            Spacer()
            HStack{
                Spacer()
                !isRunning ?
                Button(action: startTimer, label: {
                    Text("Start")
                }) :
                Button(action: stopTimer, label: {
                    Text("Stop")
                })
                
                Spacer()
                !isRunning ?
                Button(action: resetTimer, label: {
                    Text("Reset")
                }) :
                Button(action: lapTimer, label: {
                    Text("Lap")
                })
                Spacer()
            }
            Spacer()
            
            
            
        }
        .sheet(isPresented: $editSettings){
            SetUp(distance: $distance, splitDistance: $splitDistance, unit: $unit, runners: $runners, newRunner: "").padding(.top)
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}


struct SetUp: View {
    @Binding var distance: Double?
    @Binding var splitDistance: Double?
    @Binding var unit : String
    @Binding var runners : [Runner]
    @State public var newRunner : String
    
    @Environment(\.dismiss) private var dismiss
    
    func addRunner(){
        runners.append(Runner(name: newRunner))
        newRunner = ""
    }
    
    var body: some View {
        Text("Racing Stopwatch").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        Form {
            HStack{
                TextField("5000", value: $distance, format:.number)
            }
            TextField("Splits", value: $splitDistance, format:.number)
            Picker("Unit", selection: $unit) {
                Text("Meters").tag("m")
                Text("Kilometers").tag("km")
                Text("Miles").tag("mi")
            }
            List {
//                ForEach(runners, id: self.name) { runner in
//                    Text(runner.name)
//                }
                ForEach($runners, editActions: [.all]) { $runner in
                    Text(runner.name)
                        .deleteDisabled(runners.count < 2)
                }
                
            
            }
            HStack{
                TextField("John Doe", text: $newRunner)
                Button(action: addRunner, label: {
                    Text("Add Runner")
                })
            }
            
            
        }
        Button("Start Timing") {
            dismiss()
        }
    }
}
