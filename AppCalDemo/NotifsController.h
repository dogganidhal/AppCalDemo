//
//  NotifsController.h
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationManager.h"

@interface NotifsController : UITableViewController<NotificationsDelegate>

- (void)reloadController;

@end
