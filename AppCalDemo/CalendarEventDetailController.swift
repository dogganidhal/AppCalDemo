//
//  CalendarEventDetailController.swift
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

@objc open class CalendarEventDetailController: DetailController {
    
    internal var appDelegate = UIApplication.shared.delegate as! AppDelegate
    internal var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    internal var eventUID: String? {
        return (eventToDisplay as! AppsoluteCalendarDefaultObject).event?.value(forKey: "UID") as? String
    }
    
    open var calendarEvent: GenericEvent? {
        do {
            let eventUID = self.eventUID ?? ""
            let fetchRequest: NSFetchRequest<GenericEvent> = GenericEvent.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "uid == %@", argumentArray: [eventUID])
            fetchRequest.fetchLimit = 1
            let fetchedObjects = try context.fetch(fetchRequest)
            return fetchedObjects.first
        } catch {
            return nil
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var image: UIImageView!

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
        
        titleLabel.font = FontBook.boldFont(ofSize: 18)
        titleLabel.textColor = Settings.mainColor
        titleLabel.text = calendarEvent?.summary
        
        locationLabel.text = calendarEvent?.location
        locationLabel.font = FontBook.regularFont(ofSize: 16)
        locationLabel.textColor = Settings.appTheme == .dark ? .white : .black
        
        timeLabel.font = FontBook.regularFont(ofSize: 14)
        timeLabel.textColor = Settings.mainColor
        
        notesLabel.text = calendarEvent?.notes
        notesLabel.font = FontBook.regularFont(ofSize: 16)
        notesLabel.textColor = Settings.appTheme == .dark ? .white : .black
        
        guard let startDate: String = calendarEvent?.startDateString,
            let startTime: String = calendarEvent?.startTimeString else { return }
        let allDay = calendarEvent?.allDay
        timeLabel.text = startDate + (allDay! ? "" : " at " + startTime)
        guard let imageData = calendarEvent?.image else { return }
        image.image = UIImage(data: imageData)
        
    }
    
    @objc private func editEvent() {
        guard let editedCalendarEvent = self.calendarEvent else { return }
        let editEventController = EditCalendarEventController()
        editEventController.editedCalendarEvent = editedCalendarEvent
        navigationController?.pushViewController(editEventController, animated: true)
    }

}
