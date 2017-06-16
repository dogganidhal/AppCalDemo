//
//  DetailController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

class DetailController: BaseController {
    
    open var eventToDisplay: AppsoluteCalendarDefaultObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reload()
    }

}
