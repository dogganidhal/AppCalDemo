//
//  MealEvent.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

public enum MealType: String {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
}

@objc open class MealEvent: NSManagedObject {
    
    @NSManaged open var allDay: Bool
    @NSManaged open var endDate: Date
    @NSManaged open var startDate: Date
    @NSManaged open var image: Data
    @NSManaged open var location: String
    @NSManaged open var mealType: Int16
    @NSManaged open var notes: String
    @NSManaged open var recurrency_STRING: String
    @NSManaged open var startTimeString: String
    @NSManaged open var endTimeString: String
    @NSManaged open var summary: String
    @NSManaged open var uid: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealEvent> {
        return NSFetchRequest<MealEvent>(entityName: "MealEvent")
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        allDay = false
        endDate = Date()
        startDate = Date()
        image = Data()
        location = ""
        mealType = 0
        notes = ""
        recurrency_STRING = ""
        startTimeString = ""
        endTimeString = ""
        summary = ""
        uid = ""
    }

}
