//
//  FoodEventController.swift
//  AppCalDemo
//
//  Created by Nidhal on 20.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

@objc open class FoodEventController: DetailController {
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    open var mealEvent: MealEvent? {
        do {
            let eventUID = self.eventUID ?? ""
            let fetchRequest: NSFetchRequest<MealEvent> = MealEvent.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "uid == %@", argumentArray: [eventUID])
            fetchRequest.fetchLimit = 1
            let fetchedObjects = try context.fetch(fetchRequest)
            return fetchedObjects.first
        } catch {
            return nil
        }
    }
    
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    private var eventUID: String? {
        return (eventToDisplay as! AppsoluteCalendarDefaultObject).event?.value(forKey: "UID") as? String
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editEvent))
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    internal func setupView() {
        view.backgroundColor = Settings.appTheme == .light ? .white : .darkGray
        
        mealTypeLabel.font = FontBook.boldFont(ofSize: 18)
        mealTypeLabel.textColor = Settings.mainColor
        mealTypeLabel.text = {
            guard mealEvent != nil else { return nil }
            switch mealEvent!.mealType {
            case 0: return "Breakfast"
            case 1: return "Lunch"
            default: return "Dinner"
            }
        }()
        
        titleLabel.text = mealEvent?.summary
        titleLabel.font = FontBook.regularFont(ofSize: 16)
        titleLabel.textColor = Settings.appTheme == .dark ? .white : .black
        
        timeLabel.font = FontBook.regularFont(ofSize: 14)
        timeLabel.textColor = Settings.mainColor
        
        notesLabel.text = mealEvent?.notes
        notesLabel.font = FontBook.regularFont(ofSize: 16)
        notesLabel.textColor = Settings.appTheme == .dark ? .white : .black
        
        guard let startDate: String = mealEvent?.startDateString,
            let startTime: String = mealEvent?.startTimeString else { return }
        let allDay = mealEvent?.allDay
        timeLabel.text = startDate + (allDay! ? "" : " at " + startTime)
        guard let imageData = mealEvent?.image else { return }
        image.image = UIImage(data: imageData)
        
    }
    
    @objc private func editEvent() {
        guard let editedFoodEvent = self.mealEvent else { return }
        let editEventController = EditFoodEventController()
        editEventController.editedFoodEvent = editedFoodEvent
        navigationController?.pushViewController(editEventController, animated: true)
    }
    
}
