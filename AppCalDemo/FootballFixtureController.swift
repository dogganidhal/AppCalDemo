//
//  FootballFixtureController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

class FootballFixtureController: DetailController {
    
    fileprivate var summaryTextView: UITextView = UITextView()
    fileprivate var dateLabel: UILabel = UILabel()
    fileprivate var locationLabel: UILabel = UILabel()
    fileprivate var notesLabel: UILabel = UILabel()
    fileprivate var event: NSDictionary? {
        return self.eventToDisplay?.event
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        reloadView()
    }

    override func reloadView() {
        // ** Content settings
        let eventDate = event?.value(forKey: "STARTDATE") as? Date
        if eventDate != nil {
            let dateText: String? = "\(event?.value(forKey: "startDateString") ?? "") at " + (event?.value(forKey: "startTimeString") as! String)
            dateLabel.text = dateText
        }
        summaryTextView.text = event?.value(forKey: "SUMMARY") as? String
        notesLabel.text = event?.value(forKey: "NOTES") as? String
        locationLabel.text = event?.value(forKey: "LOCATION") as? String
        summaryTextView.font = FontBook.boldFont(ofSize: 16)
        summaryTextView.textColor = Settings.mainColor
        dateLabel.font = FontBook.regularFont(ofSize: 14)
        locationLabel.font = FontBook.regularFont(ofSize: 14)
        locationLabel.textColor = Settings.mainColor
        notesLabel.font = FontBook.regularFont(ofSize: 14)
        // ** Layout settings
        [summaryTextView, dateLabel, locationLabel, notesLabel].forEach { (subview: UIView) in
            self.view.addSubview(subview)
            subview.sizeToFit()
            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        }
        summaryTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        summaryTextView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        summaryTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        dateLabel.topAnchor.constraint(equalTo: summaryTextView.bottomAnchor, constant: 16).isActive = true
        locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16).isActive = true
        notesLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16).isActive = true
    }

}








