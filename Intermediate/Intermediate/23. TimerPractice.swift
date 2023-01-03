//
//  TimerPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/03.
//

import SwiftUI
import Combine

struct TimerPractice: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var currentDate: Date = Date()
    
    @State var count: Int = 10
    @State var finishedText: String? = nil
    
    @State var timeRemining: String = ""
    let futureDate: Date = Calendar
                            .current
                            .date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    let timer2 = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var count2: Int = 0
    
    let timer3 = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    @State var count3: Int = 0
    
    func updateTimeRemaining() {
        let remaining = Calendar
                        .current
                        .dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        
        timeRemining = "\(hour):\(minute):\(second)"
    }
    
    var dateFormatter: DateFormatter {
       let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))],
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea(.all)
            
            VStack {
                Text(dateFormatter.string(from: currentDate))
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                
                Spacer()
                    .frame(height: 10)
                
                Text(finishedText ?? "\(count)")
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                
                Spacer()
                    .frame(height: 10)
                
                Text(timeRemining)
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                
                Spacer()
                    .frame(height: 10)
                HStack {
                    Circle().fill(.white)
                        .offset(y: count2 == 1 ? 30 : 0)
                    
                    Circle().fill(.white)
                        .offset(y: count2 == 2 ? 20 : 0)
                    
                    Circle().fill(.white)
                        .offset(y: count2 == 3 ? 30 : 0)
                }
                .frame(width: 200)
                
                Spacer()
                    .frame(height: 30)
                
                TabView(selection: $count3) {
                    Rectangle()
                        .foregroundColor(.red)
                        .tag(0)
                    
                    Rectangle()
                        .foregroundColor(.green)
                        .tag(1)
                    
                    Rectangle()
                        .foregroundColor(.orange)
                        .tag(2)
                    
                    Rectangle()
                        .foregroundColor(.blue)
                        .tag(3)
                    
                    Rectangle()
                        .foregroundColor(.pink)
                        .tag(4)
                }
                .tabViewStyle(.page)
                .frame(height: 150)
            }
            .padding()
        }
        .onReceive(timer) { value in
            currentDate = value
        }
        .onReceive(timer) { value in
            if count < 1 {
                finishedText = "Oops!"
            } else {
                count -= 1
            }
        }
        .onReceive(timer) { _ in
            updateTimeRemaining()
        }
        .onReceive(timer2) { _ in
            withAnimation(.easeInOut) {
                count2 = count2 == 3 ? 0 : count2 + 1
            }
        }
        .onReceive(timer3) { _ in
            withAnimation(.easeInOut) {
                count3 = count3 == 5 ? 0 : count3 + 1
            }
        }
    }
}

struct TimerPractice_Previews: PreviewProvider {
    static var previews: some View {
        TimerPractice()
    }
}
