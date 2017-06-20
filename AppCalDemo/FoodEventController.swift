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
        mealTypeLabel.font = FontBook.boldFont(ofSize: 16)
        mealTypeLabel.textColor = Settings.mainColor
        mealTypeLabel.text = mealEvent?.value(forKey: "MEALTYPE") as? String
        
        titleLabel.text = mealEvent?.value(forKey: "SUMMARY") as? String
        titleLabel.font = FontBook.regularFont(ofSize: 15)
        titleLabel.textColor = Settings.appTheme == .dark ? .white : .black
        
        timeLabel.text = mealEvent?.value(forKey: "startTimeString") as? String
        timeLabel.font = FontBook.regularFont(ofSize: 14)
        timeLabel.textColor = Settings.mainColor
        
        notesLabel.text = mealEvent?.value(forKey: "NOTES") as? String
        notesLabel.font = FontBook.regularFont(ofSize: 15)
        notesLabel.textColor = Settings.appTheme == .dark ? .white : .black
        
        guard let imageData = mealEvent?.value(forKey: "IMAGE") as? Data else { return }
        image.image = UIImage(data: imageData)
    }

}
