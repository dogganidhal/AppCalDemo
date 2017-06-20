//
//  FoodController.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

class FoodController: TemplateNavigationController {
    
    internal var addButton: UIButton = UIButton()
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAddButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadEvents()
    }
    
    internal func loadEvents() {
        guard events.count == 0 else { return }
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.layer.cornerRadius = addButton.frame.height / 2.0
    }
    
    public override func calendarComponentControllerWantsTransition(_ controller: AppsoluteCalendarTemplateViewController, toDate date: Date) {
        switch controller {
        case is YearController:
            pushViewController(monthController, animated: false)
        case is MonthController:
            pushViewController(dayController, animated: true)
        default:
            let foodEventController = FoodEventController()
            foodEventController.eventToDisplay = lastUsedData // get the event to display
            pushViewController(foodEventController, animated: true)
        }
        lastUsedDate = date
    }
    
    
    
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
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
        addButton.tintColor = Settings.mainColor != .white ? .white : .darkGray
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
    
    override func reload() {
        super.reload()
        setupAddButton()
    }
    
}
