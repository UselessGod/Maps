//
//  NotificationService.swift
//  NotificationService
//
//  Created by Дмитрий Емельянов on 24.11.2021.
//

import Foundation
import UserNotifications

class NotificationService {
    private init() {}
    
    static let shared = NotificationService()
    
    private let center = UNUserNotificationCenter.current()
    
    func request() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Разрешение получено")
            } else {
                print("Разрешение не получено")
            }
        }
    }
    
    func checkForAuth(completion: @escaping (UNAuthorizationStatus) -> Void) {
        center.getNotificationSettings {
            completion($0.authorizationStatus)
        }
    }
    
    func sendNotificatioRequest(){
       let content = makeNotificationContent()
       let trigger = makeIntervalNotificatioTrigger()
       let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
    
        center.add(request) { error in
            if let error = error {
                print("Something is wrong", error.localizedDescription)
            }
        }
    }
    
    func makeNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        
        content.title = "Приготовьтесь"
        content.subtitle = "Через 50 км"
        content.body = "Поверините налево"
        
        let attachment = try! UNNotificationAttachment(identifier: "image", url: Bundle.main.url(forResource: "left", withExtension: "png")!, options: nil)
        content.attachments = [attachment]
        
        content.badge = 1
        return content
        }

    
    func makeIntervalNotificatioTrigger() -> UNNotificationTrigger {
        UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    }
    
}
