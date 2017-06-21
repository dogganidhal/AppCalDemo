//
//  DetailController.swift
//  AppCalDemo
//
//  Created by Nidhal on 16.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

@objc open class DetailController: BaseController {
    
    open var eventToDisplay: AnyObject? {
        didSet {
            reloadView()
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reload()
    }

    open func reloadView() {
        // Do any setup after an event is being set
    }
    
}
