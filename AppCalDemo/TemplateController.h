//
//  TemplateController.h
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// This class is a subclass of UINavigationController and the super almost every ViewController in this project, it has the ability to reload each time the settings change with the method -reloadController.

@interface TemplateController : UINavigationController

- (void)reloadController;

@end

