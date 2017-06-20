//
//  FoodEventController.swift
//  AppCalDemo
//
//  Created by Nidhal on 20.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

class FoodEventController: DetailController {

    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    private var mealEvent: NSDictionary? {
        return eventToDisplay?.event
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editEvent))
    }
    
    internal func setupView() {
        mealTypeLabel.font = FontBook.boldFont(ofSize: 18)
        mealTypeLabel.textColor = Settings.mainColor
        mealTypeLabel.text = mealEvent?.value(forKey: "MEALTYPE") as? String
        
        titleLabel.text = mealEvent?.value(forKey: "SUMMARY") as? String
        titleLabel.font = FontBook.regularFont(ofSize: 16)
        titleLabel.textColor = Settings.appTheme == .dark ? .white : .black
        
        timeLabel.font = FontBook.regularFont(ofSize: 14)
        timeLabel.textColor = Settings.mainColor
        
        notesLabel.text = mealEvent?.value(forKey: "NOTES") as? String
        notesLabel.font = FontBook.regularFont(ofSize: 16)
        notesLabel.textColor = Settings.appTheme == .dark ? .white : .black
        
        guard let startDate: String = mealEvent?.value(forKey: "startDateString") as? String,
            let startTime: String = mealEvent?.value(forKey: "startTimeString") as? String else { return }
        let allDay = mealEvent?.value(forKey: "ALLDAY") as! Bool
        timeLabel.text = startDate + (allDay ? "" : " at " + startTime)
        guard let imageData = mealEvent?.value(forKey: "IMAGE") as? Data else { return }
        image.image = UIImage(data: imageData)

    }
    
    @objc private func editEvent() {
        let editEventController = EditFoodEventController()
        navigationController?.pushViewController(editEventController, animated: true)
    }

}
