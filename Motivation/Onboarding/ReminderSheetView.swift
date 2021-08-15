//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    func updateUIView(_ uiView: AnimationView, context: Context) {
        
    }
    
    var animationName: String
    
    func makeUIView(context: Context) -> AnimationView {
        let view = AnimationView(name: animationName, bundle: Bundle.main)
        view.loopMode = .loop
        view.play()
        
        return view
    }
}

struct ReminderOnboardingView: View {
    @State private var reminderFrequency = 4.0
    @State private var reminderStartTime = Date(timeIntervalSince1970: TimeInterval(7*60*60))
    @State private var reminderEndTime = Date(timeIntervalSince1970: TimeInterval(19*60*60))
    @Binding var showOnboarding: Bool
    @EnvironmentObject var manager: LocalNotificationManager
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    showOnboarding.toggle()
                    
                })  {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                }.buttonStyle(ColoredButtonStyle())
                
            }
            VStack {
                LottieView(animationName: "countdown")
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(0.2)
            }.padding()
            
            //  Form {
            VStack {
                Text("Set daily reminders.")
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text("Remind me")
                        .fontWeight(.bold)
                    Stepper(value: $reminderFrequency, in: 3...4, step: 1.0) {
                        Text("\(reminderFrequency, specifier: "%g") times")
                            .fontWeight(.bold)
                    }
                    
                }
                //                DatePicker(selection: $reminderStartTime, displayedComponents: .hourAndMinute) {
                //                    Text("Start at")
                //                        .fontWeight(.bold)
                //                }
                //                DatePicker(selection: $reminderEndTime, displayedComponents: .hourAndMinute) {
                //                    Text("End at")
                //                        .fontWeight(.bold)
                //                }
                
            }
            Spacer()
            Button(action: {setNotification()}, label: {
                Text("Continue")
                //                    .font(.title3)
                //                    .fontWeight(.heavy)
            }).buttonStyle(ColoredButtonStyle())
            
        }.padding(.horizontal)
        .edgesIgnoringSafeArea(.top)
        
    }
    
    func setNotification() {
        
        let firstDateComponents = Calendar.current.dateComponents([.hour, .minute], from: reminderStartTime)
        let lastDateComponents = Calendar.current.dateComponents([.hour, .minute], from: reminderEndTime)
        
        var dateComponentsArray = [firstDateComponents, lastDateComponents]
        
        var hour = 8
        let minute = 0
        
        for _ in 1...reminderFrequency.toInt()-2 {
            
//            let hour = Int.random(in: (firstDateComponents.hour!-1)..<(lastDateComponents.hour!-1) )
//            let minute = Int.random(in: 0...59)
            hour += 1
                        
            let date = Date(timeIntervalSince1970: TimeInterval(hour*60*60 + minute*60))
            
            let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: date)
            print("hour: \(String(describing: dateComponent.hour)) minute: \(String(describing: dateComponent.minute))")
            
            dateComponentsArray.append(dateComponent)
        }
        for dateComponents in dateComponentsArray {
            
            getRandomQuote { quote in
                manager.addNotification(title: quote.quoteAuthor, body: quote.quoteText, dateComponents: dateComponents)
                
                print(quote.id)
                
            }
            
        }
        
        manager.schedule()
        showOnboarding.toggle()
                
    }
}
