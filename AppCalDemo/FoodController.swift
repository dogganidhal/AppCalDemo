//
//  FoodController.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

@objc open class FoodController: TemplateNavigationController, NotificationsDataSource {
    
    internal var addButton: UIButton = UIButton()
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    private var notificationObservingTimer: Timer!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAddButton()
        NotificationManager.shared.dataSource = self
        NotificationManager.shared.startNotificationObserving()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadEvents()
        dayController.dayView?.reloadDays()
        monthController.monthView?.reloadData()
        yearController.yearView?.reloadData()
    }
    
    internal func loadEvents() {
        events = NSMutableArray()
        var eventArray = NSMutableArray()
        do {
            eventArray = try context.fetch(MealEvent.fetchRequest()) as! NSMutableArray
        } catch {
            print("CoreData Error, can't fetch data")
        }
        for event in eventArray {
            events.add((event as! MealEvent).dictionaryFromEvent())
        }
        appCal.reloadEvents(events)
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.layer.cornerRadius = addButton.frame.height / 2.0
    }
    
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
    
    
    
    override public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        switch viewController {
        case is YearController:
            setAddButtonVisibility(true)
        case is MonthController:
            monthController.monthView.scrollToDateAnimated(lastUsedDate!, animated: true)
            setAddButtonVisibility(true)
        case is DayController:
            // TODO: Scroll to the selected date
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
    
    internal func addEvent() {
        pushViewController(NewFoodEventController(), animated: true)
    }
    
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
    
    override open func reload() {
        super.reload()
        setupAddButton()
    }
    
    public func notifyBeforeTimeInterval() -> TimeInterval {
        return 24 * 3600 // a day
    }
    
    public func refreshInterval() -> TimeInterval {
        return 3
    }
    
    public func notificationManager(_ manager: NotificationManager, objectAt date: Date) -> Any? {
        for event in events {
            let startDate = (event as? NSDictionary)?.value(forKey: "STARTDATE") as? Date
            guard startDate != nil else { break }
            if date.timeIntervalSince(startDate!) < notifyBeforeTimeInterval() {
                return event
            }
        }
        return nil
    }
    
}
