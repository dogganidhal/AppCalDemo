//
//  FoodEventController.swift
//  AppCalDemo
//
//  Created by Nidhal on 20.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

// This class is a subclass of DetailController, so it shows a particular MealEvent.

@objc open class FoodEventController: DetailController {
    
    // Showtcuts to the appDelegate and the viewContext.
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    // The MealEvent to be shown, retrieved from core data.
    open var mealEvent: MealEvent? {
        do {
            let eventUID = self.eventUID ?? (eventToDisplay as! AppsoluteCalendarDefaultObject).event?.value(forKey: "UID") as! String
            let fetchRequest: NSFetchRequest<MealEvent> = MealEvent.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "uid == %@", argumentArray: [eventUID])
            fetchRequest.fetchLimit = 1
            let fetchedObjects = try context.fetch(fetchRequest)
            return fetchedObjects.first
        } catch {
            return nil
        }
    }
    // Outlets displaying the current pieces of data in the event.
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    // Helpful to filter the core data and get the exact event.
    open var eventUID: String?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editEvent))
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    internal func setupView() {
        // Setup of the Labels (font, text, ...).
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
        
        locationLabel.text = mealEvent?.location
        locationLabel.font = FontBook.regularFont(ofSize: 16)
        locationLabel.textColor = UIColor(fromHex: 0x1E88E5)
        
        notesLabel.text = mealEvent?.notes
        notesLabel.font = FontBook.regularFont(ofSize: 16)
        notesLabel.textColor = Settings.appTheme == .dark ? .white : .black
        
        guard let startDate: String = mealEvent?.startDateString,
            let startTime: String = mealEvent?.startTimeString else { return }
        let allDay = mealEvent?.allDay
        timeLabel.text = startDate + (allDay! ? "" : " at " + startTime)
        guard let imageData = mealEvent?.image else { return }
        image.image = UIImage(data: imageData)
        image.clipsToBounds = true
        image.layer.cornerRadius = 6.0
        
    }
    
    // Handles the edit button and pushes EditFoodEventController.
    @objc private func editEvent() {
        guard let editedFoodEvent = self.mealEvent else { return }
        let editEventController = EditFoodEventController()
        editEventController.editedFoodEvent = editedFoodEvent
        navigationController?.pushViewController(editEventController, animated: true)
    }
    
}
