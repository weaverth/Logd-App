//
//  Trips.swift
//  Logd
//
//  Created by Teddy Weaver on 12/3/21.
//

import Foundation
import NotificationCenter

class Trips {
    var tripsArray: [Trip] = []
    
    func loadData(completed: @escaping ()->() ){
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("trips").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            tripsArray = try jsonDecoder.decode(Array<Trip>.self, from: data)
            
        }
        catch{
            print("🤬 Error: could not load data \(error.localizedDescription)")
        }
        completed()
    }
    
    func saveData(){
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("trips").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try?jsonEncoder.encode(tripsArray)
        do{
            try data?.write(to: documentURL, options: .noFileProtection)
        }
            catch{
                print("🤬 Error: could not save data\(error.localizedDescription)")
        }
//        setNotifications()
    }
    
//    func setNotifications(){
//        guard trips.count > 0 else{
//            return
//        }
//        // remove all notifications
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//
//        // recreate them with updated data
//        for index in 0..<trips.count{
//            if trips[index].reminderSet {
//                let trip = trips[index]
//                itemsArray[index].notificationID = LocalNotificationManager.setCalendarNotification(title: toDoItem.name, subtitle: "", body: toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.date)
//            }
//        }
//    }
}
