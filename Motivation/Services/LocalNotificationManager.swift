//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//


import UserNotifications

struct Notification {
    var id: String
    var title: String
    var body: String
    var dateComponents: DateComponents
}

class LocalNotificationManager: ObservableObject {
    var notifications = [Notification]()
    
    func requestPermission() {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted == true && error == nil {
                    self.scheduleNotifications()
                    // We have permission!
                }
        }
    }
    
    func addNotification(title: String, body: String, dateComponents: DateComponents) {
        notifications.append(Notification(id: UUID().uuidString, title: title, body: body, dateComponents: dateComponents))
    }
    
    func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
                        
            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Notification id: \(notification.id), hour: \(String(describing: notification.dateComponents.hour)), minutes: \(String(describing: notification.dateComponents.minute))")
            }
        }
    }
    
    func schedule() {
          UNUserNotificationCenter.current().getNotificationSettings { settings in
              switch settings.authorizationStatus {
              case .notDetermined:
                self.requestPermission()
              case .authorized, .provisional:
                self.scheduleNotifications()
              default:
                  break
              }
          }
      }
}
