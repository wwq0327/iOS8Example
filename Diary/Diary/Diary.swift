//
//  Diary.swift
//  
//
//  Created by wyatt on 15/6/14.
//
//

import Foundation
import CoreData

@objc(Diary)
class Diary: NSManagedObject {

    @NSManaged var content: String
    @NSManaged var created_at: NSDate
    @NSManaged var location: String?
    @NSManaged var month: NSNumber
    @NSManaged var title: String?
    @NSManaged var year: NSNumber

}


extension Diary {
    func updateTimeWithDate(date: NSDate){
        self.created_at = date
        self.year = NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitYear, fromDate: date)
        self.month = NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitMonth, fromDate: date)
    }
}