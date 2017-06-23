//
//  FoodController.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

// This class handles adding, editing, displaying and removing AppsoluteCalendar-based meal events and save them to the core data.

@objc open class FoodController: TemplateNavigationController, NotificationsDataSource {
    
    // These two properties are a shortcut to the appDelegate and the viewContext instances.
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    // This property is a container of the saved events in the core data.
    override var events: NSMutableArray {
        get {
            // Fetching the events from core data.
            let localEvents = NSMutableArray()
            var eventArray = NSMutableArray()
            do {
                eventArray = try context.fetch(MealEvent.fetchRequest()) as! NSMutableArray
            } catch {
                print("CoreData Error, can't fetch data")
            }
            for event in eventArray {
                localEvents.add((event as! MealEvent).dictionaryFromEvent())
            }
            return localEvents
        } set { }
    }
    
    // The circular addButton at the bottom-left corner.
    internal var addButton: UIButton = UIButton()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAddButton()
        NotificationManager.shared.dataSources?.add(self)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload the events and refresh the UI before the Controller is shown.
        appCal.reloadEvents(events)
        monthController.monthView?.reloadData()
        yearController.yearView?.reloadData()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Sets the circular corner after the addButton is placed on the view.
        addButton.layer.cornerRadius = addButton.frame.height / 2.0
    }
    
    // MARK:- CalendarComponentControllerDelegate method.
    
    // In the following method, we push the proper controller by checking the sender, and pass the necessary data.
    public override func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        switch controller {
        case is YearController:
            pushViewController(monthController, animated: false)
        case is MonthController:
            dayController.receivedDate = date
            pushViewController(dayController, animated: true)
        default:
            let foodEventController = FoodEventController()
            foodEventController.eventToDisplay = lastUsedData
            pushViewController(foodEventController, animated: true)
        }
        lastUsedDate = date
    }
    
    // MARK:- NavigationController Delegate method.
    
    // In this override, we do additional setup on the shown controller after it's initialization.
    override public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        switch viewController {
        case is YearController:
            setAddButtonVisibility(true)
        case is MonthController:
            monthController.monthView.scrollToDateAnimated(lastUsedDate!, animated: true)
            setAddButtonVisibility(true)
        case is DayController:
            setAddButtonVisibility(true)
            break
        case is FoodEventController:
            (viewController as! FoodEventController).eventToDisplay = lastUsedData as? AppsoluteCalendarDefaultObject
            setAddButtonVisibility(false)
        case is NewFoodEventController:
            setAddButtonVisibility(false)
            break
        default:
            setAddButtonVisibility(false)
            break
        }
    }
    
    // This method sets the addButton on the bottom-left corner using auto-layout.
    internal func setupAddButton() {
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        addButton.tintColor = Settings.appTheme != .dark ? .white : .darkGray
        addButton.backgroundColor = Settings.mainColor.withAlphaComponent(0.90)
        addButton.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    // This method is called wvery time the addButton is tapped.
    internal func addEvent() {
        pushViewController(NewFoodEventController(), animated: true)
    }
    
    // Animates the show/hide of the addButton.
    internal func setAddButtonVisibility(_ visible: Bool) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            if self!.addButton.isHidden {
                self?.addButton.isHidden = !visible
            }
            self?.addButton.alpha = visible ? 1.0 : 0.0
        }) { [weak self] (finished) in
            self?.addButton.isHidden = !visible
        }
    }
    
    
    // Reloads the controller when asked.
    override open func reload() {
        super.reload()
        setupAddButton()
    }
    
    // MARK:- NotificationsDataSource method.
    
    // In this method, we send the events near to the current date, one day before and one after this moment.
    public func notificationManager(_ manager: NotificationManager, objectsAt date: Date) -> NSMutableArray {
        var eventsForNotifications = Array<Dictionary<String, Any>>()
        for event in self.events {
            let startDate = (event as? NSDictionary)?.value(forKey: "STARTDATE") as? Date
            guard startDate != nil else { break }
            if startDate!.timeIntervalSince(date) < 3600 * 24 &&
                startDate!.timeIntervalSince(date) > -3600 * 24 { // an interval of two days, a day after and a day before
                (event as! NSDictionary).setValue("Diary", forKey: "SENDER")
                eventsForNotifications.append(event as! [String : Any])
            }
        }
        return eventsForNotifications as! NSMutableArray
    }
    
}
