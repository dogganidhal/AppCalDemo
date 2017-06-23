//
//  NotifsController.h
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationManager.h"

// This class is a subclass of UITableViewController, which handles the display of the near events from the calendar and the food controller.

@interface NotifsController : UITableViewController<NotificationsDelegate>

- (void)reloadController;

@end
