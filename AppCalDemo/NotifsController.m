//
//  NotifsController.m
//  AppCalDemo
//
//  Created by Nidhal on 21.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "NotifsController.h"
#import "AppCalDemo-Swift.h"
#import "FontBook.h"
#import "Settings.h"

@interface NotifsController ()

// NSMutableArray of the event in the next day.
@property (nonatomic, strong) NSMutableArray *upcomingEvents;
// NSMutableArray of the event in the last day.
@property (nonatomic, strong) NSMutableArray *lateEvents;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation NotifsController {
    NSString *reusableCellIdentifier;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadController];
    NotificationManager.shared.delegate = self;
    self.upcomingEvents = [[NSMutableArray alloc] init];
    self.lateEvents = [[NSMutableArray alloc] init];
    self->reusableCellIdentifier = @"notificationsCell";
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:self->reusableCellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self setupView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Start the animating of the activity indicator view while waiting for the next update cycle.
    [self.activityIndicatorView startAnimating];
}

// Sets up the activity indicator view and the tableView.
- (void)setupView {
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(Settings.appTheme == ApplicationThemeDark ? UIActivityIndicatorViewStyleWhite : UIActivityIndicatorViewStyleGray)];
    [self.view addSubview:self.activityIndicatorView];
    self.activityIndicatorView.center = CGPointMake(CGRectGetMidX(UIScreen.mainScreen.bounds), CGRectGetMidY(UIScreen.mainScreen.bounds));
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.tableView.backgroundColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRowsInSection = section == 0 ? self.upcomingEvents.count : self.lateEvents.count;
    return numberOfRowsInSection > 0 ? numberOfRowsInSection : 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self->reusableCellIdentifier];
    // Configure the cell...
    cell.backgroundColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
    cell.textLabel.font = [FontBook regularFontOfSize:18];
    cell.textLabel.textColor = Settings.appTheme == ApplicationThemeDark ? [UIColor whiteColor] : [UIColor blackColor];
    if ((indexPath.section == 0 ? self.upcomingEvents : self.lateEvents).count == 0) {
        cell.textLabel.text = @"Nothing in this section";
        return cell;
    }
    NSDictionary *object = indexPath.section == 0 ? [self.upcomingEvents objectAtIndex:indexPath.row] : [self.lateEvents objectAtIndex:indexPath.row];
    cell.textLabel.text = [object objectForKey:@"SUMMARY"];
    NSString *detailLabelText = [NSString stringWithFormat:@"%@ at %@", [object objectForKey:@"startDateString"], [object objectForKey:@"startTimeString"]];
    cell.detailTextLabel.text = detailLabelText;
    cell.detailTextLabel.textColor = Settings.appTheme == ApplicationThemeDark ? [UIColor lightGrayColor] : [UIColor grayColor];
    cell.detailTextLabel.font = [FontBook lightFontOfSize:14];
    UILabel *accessoryLabel = [[UILabel alloc] init];
    accessoryLabel.text = (NSString *)[object objectForKey:@"SENDER"];
    accessoryLabel.textColor = Settings.appTheme == ApplicationThemeDark ? [UIColor lightGrayColor] : [UIColor grayColor];
    accessoryLabel.font = [FontBook regularFontOfSize:15];
    [accessoryLabel sizeToFit];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView = accessoryLabel;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"UPCOMING EVENTS" : @"LATE EVENTS";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [FontBook boldFontOfSize:18];
    header.textLabel.textColor = [Settings mainColor];
    header.tintColor = Settings.appTheme == ApplicationThemeDark ? [[UIColor whiteColor] colorWithAlphaComponent:0.15] : [UIColor groupTableViewBackgroundColor];
    [header.textLabel sizeToFit];
}

// Handling what happens when a cell is selected, it pushes a DetailController of the selected event.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *eventUID = [[(indexPath.section == 0 ? self.upcomingEvents : self.lateEvents) objectAtIndex:indexPath.row] objectForKey:@"UID"];
    NSString *sender = [[(indexPath.section == 0 ? self.upcomingEvents : self.lateEvents) objectAtIndex:indexPath.row] objectForKey:@"SENDER"];
    if ([sender isEqualToString:@"Diary"]) {
        FoodEventController *foodController = [[FoodEventController alloc] init];
        foodController.eventUID = eventUID;
        [self.navigationController pushViewController:foodController animated:YES];
    } else {
        CalendarEventDetailController *calendarEventController = [[CalendarEventDetailController alloc] init];
        calendarEventController.eventUID = eventUID;
        [self.navigationController pushViewController:calendarEventController animated:YES];
    }
}

#pragma mark - Notifications Manager delegate method

// Handles the display of the received objects.
- (void)notificationManager:(NotificationManager * _Nonnull)manager didReceiveNotificationWithObjects:(NSMutableArray * _Nonnull)objects {
    [self.upcomingEvents removeAllObjects];
    [self.lateEvents removeAllObjects];
    for (NSDictionary *object in objects) {
        NSDate *startDate = [object valueForKey:@"STARTDATE"];
        if ([startDate timeIntervalSinceDate:[[NSDate alloc] init]] > 0) {
            [self.upcomingEvents addObject:object];
        } else {
            [self.lateEvents addObject:object];
        }
    }
    NSRange sectionsForReload = {0, 2};
    if (self.activityIndicatorView.isAnimating) {
        [self.activityIndicatorView stopAnimating];
    }
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndexesInRange:sectionsForReload] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)reloadController {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"AppCalDemo";
    titleLabel.font = [FontBook boldFontOfSize:18];
    titleLabel.textColor = [Settings mainColor];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.tintColor = Settings.mainColor;
    [self.tableView reloadData];
    [self setupView];
}

@end
