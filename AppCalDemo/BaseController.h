//
//  BaseController.h
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>

// This class is a subclass of UIViewController and the super almost every ViewController in this project, it has the ability to reload each time the settings change with the method -reloadController.

@interface BaseController : UIViewController

// This method is renamed: reload() in swift.
- (void)reloadController;

@end
