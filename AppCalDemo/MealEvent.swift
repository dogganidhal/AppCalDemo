//
//  MealEvent.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

public enum MealType: Int16 {
    case breakfast = 0
    case lunch = 1
    case dinner = 2
}

@objc open class MealEvent: NSManagedObject {
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }
    
    @NSManaged open var allDay: Bool
    @NSManaged open var endDate: Date!
    @NSManaged open var startDate: Date!
    @NSManaged open var image: Data?
    @NSManaged open var location: String?
    @NSManaged open var mealType: Int16
    @NSManaged open var notes: String?
    @NSManaged open var recurrency_STRING: String
    @NSManaged open var startTimeString: String
    @NSManaged open var endTimeString: String
    @NSManaged open var startDateString: String
    @NSManaged open var endDateString: String
    @NSManaged open var summary: String?
    @NSManaged open var uid: String
    
    private var mealTypeString: String {
        switch mealType {
        case 0:
            return "Breakfast"
        case 1:
            return "Lunch"
        default:
            return "Dinner"
        }
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealEvent> {
        return NSFetchRequest<MealEvent>(entityName: "MealEvent")
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        allDay = false
        mealType = 0
        recurrency_STRING = "none"
        uid = uuid()
    }
    
    open func dictionaryFromEvent() -> NSMutableDictionary {
        startTimeString = timeFormatter.string(from: startDate)
        endTimeString = timeFormatter.string(from: endDate)
        startDateString = dateFormatter.string(from: startDate)
        endDateString = dateFormatter.string(from: endDate)
        let dict = NSMutableDictionary()
        dict.setValue(allDay, forKey: "ALLDAY")
        dict.setValue(startDate, forKey: "STARTDATE")
        dict.setValue(endDate, forKey: "ENDDATE")
        dict.setValue(startTimeString, forKey: "startTimeString")
        dict.setValue(endTimeString, forKey: "endTimeString")
        dict.setValue(startDateString, forKey: "startDateString")
        dict.setValue(endDateString, forKey: "endDateString")
        dict.setValue(recurrency_STRING, forKey: "recurrency_STRING")
        dict.setValue(summary, forKey: "SUMMARY")
        dict.setValue(notes, forKey: "NOTES")
        dict.setValue(uid, forKey: "UID")
        dict.setValue(location, forKey: "LOCATION")
        dict.setValue(image, forKey: "IMAGE")
        dict.setValue(mealTypeString, forKey: "MEALTYPE")
        return dict
    }
    
    private func uuid() -> String {
        let uuidRef = CFUUIDCreate(nil)
        let uuidStringRef = CFUUIDCreateString(nil, uuidRef)
        return uuidStringRef! as String
    }

}
