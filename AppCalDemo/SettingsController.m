//
//  SettingsController.m
//  AppCalDemo
//
//  Created by Dogga Nidhal on 05/06/2017.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "SettingsController.h"
#import "MainTabbarController.h"
#import "BaseController.h"
#import "SettingsCell.h"
#import "DetailSettingController.h"
#import "FontBook.h"
#import "Settings.h"

@interface SettingsController ()

// An array holding the titles of the sections.
@property (nonatomic, strong) NSArray<NSString *> *sections;
// A property holding the content of the current plist settings file.
@property (nonatomic, strong) NSMutableArray<NSArray<NSDictionary *> *> *plistSettings;

@end

@implementation SettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup the logo on the navigation bar.
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"AppCalDemo";
    titleLabel.font = [FontBook boldFontOfSize:18];
    titleLabel.textColor = [Settings mainColor];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    // Cusomization.
    UIEdgeInsets separatorInset = {0};
    separatorInset.left = 8;
    separatorInset.right = 8;
    self.tableView.separatorInset = separatorInset;
    self.tableView.backgroundColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Filling sections array.
    _sections = @[@"GENERAL SETTINGS", @"APP APPEARENCE", @"CALENDAR SETTINGS", @"CALENDAR CUSTOMIZATION", @"FOOTBALL SETTINGS", @"NOTIFICATIONS SETTINGS"];
    // Registering the custom cell.
    [self.tableView registerClass:SettingsCell.class forCellReuseIdentifier:@"settingsCell"];
    // Initializing the plistSettings array.
    NSString *plistFilePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    _plistSettings = [NSMutableArray arrayWithContentsOfFile:plistFilePath];
    [_plistSettings writeToFile:plistFilePath atomically:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _plistSettings.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_plistSettings objectAtIndex:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingsCell"];
    // Configure the cell...
    NSDictionary *selectedObject = [[_plistSettings objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [selectedObject objectForKey:@"Title"];
    cell.textLabel.font = [FontBook regularFontOfSize:16];
    cell.textLabel.textColor = Settings.appTheme == ApplicationThemeDark ? [UIColor whiteColor] : [UIColor blackColor];
    cell.backgroundColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSNumber *currentValueIndex = [selectedObject objectForKey:@"selectedValue"];
    NSString *currentValue = [(NSArray *)[selectedObject objectForKey:@"allValues"] objectAtIndex:currentValueIndex.integerValue];
    if (indexPath.section == 5) {
        currentValue = [NSString stringWithFormat:@"%2.2f", ((NSNumber *)[selectedObject objectForKey:@"selectedValue"]).floatValue];
    }
    if (indexPath.section != 0) {
        cell.currentValue = currentValue != nil ? [NSString stringWithFormat:@"%@", currentValue] : @"";
    }
    return cell;
    
}

#pragma mark - Table view header display

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_sections objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [FontBook boldFontOfSize:16];
    header.textLabel.textColor = [Settings mainColor];
    header.tintColor = Settings.appTheme == ApplicationThemeDark ? [[UIColor whiteColor] colorWithAlphaComponent:0.15] : [UIColor groupTableViewBackgroundColor];
    [header.textLabel sizeToFit];
}

#pragma mark - table view delegate methods

// Handles the proper action when a cell is selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        UIAlertController *resetAlertController = [UIAlertController alertControllerWithTitle:@"Reset to the default settings?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self resetDefaultSettings];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [resetAlertController addAction:confirmAction];
        [resetAlertController addAction:cancelAction];
        [self presentViewController:resetAlertController animated:YES completion:nil];
    } else if (indexPath.section == 5) {
        UIAlertController *refreshDelaiInputAlertController = [UIAlertController alertControllerWithTitle:@"Info" message:@"Enter the refresh delai for the notifications" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // Register the entred value
            [[[_plistSettings objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] setValue:refreshDelaiInputAlertController.textFields.firstObject.text forKey:@"selectedValue"];
            [_plistSettings writeToFile: [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"] atomically:YES];
            NSRange sectionsToReload = {5, 1};
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndexesInRange:sectionsToReload] withRowAnimation:UITableViewRowAnimationFade];
            NotificationManager.shared.refreshInterval = [refreshDelaiInputAlertController.textFields.firstObject.text floatValue];
            [NotificationManager.shared stopNotificationObserving];
            [NotificationManager.shared startNotificationObserving];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [refreshDelaiInputAlertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [refreshDelaiInputAlertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = [NSString stringWithFormat:@"%@", [[[_plistSettings objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"selectedValue"]];
        }];
        [refreshDelaiInputAlertController addAction:submitAction];
        [refreshDelaiInputAlertController addAction:cancelAction];
        [self presentViewController:refreshDelaiInputAlertController animated:YES completion:nil];
    }
    [self.navigationController pushViewController:[[DetailSettingController alloc] initWithIndexPath:indexPath] animated:YES];
}

#pragma mark - Method to reset to the default settings

- (void)resetDefaultSettings {
    NSString *defaultSettingsPath = [[NSBundle mainBundle] pathForResource:@"DefaultSettings" ofType:@"plist"];
    NSMutableArray *defaultSettings = [NSMutableArray arrayWithContentsOfFile:defaultSettingsPath];
    _plistSettings = defaultSettings;
    [_plistSettings writeToFile:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"] atomically:YES];
    [(MainTabbarController *)self.tabBarController viewDidLoad];
    [(MainTabbarController *)self.tabBarController reloadController];
    [UIApplication sharedApplication].statusBarStyle = Settings.appTheme == ApplicationThemeLight ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
    [self reload];
}

#pragma mark - Method asking to reload data

- (void)reload {
    NSString *plistFilePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    _plistSettings = [NSMutableArray arrayWithContentsOfFile:plistFilePath];
    [self.tableView reloadData];
    self.tableView.backgroundColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
}

// Reload the Controller when asked.
- (void)reloadController {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"AppCalDemo";
    titleLabel.font = [FontBook boldFontOfSize:18];
    titleLabel.textColor = [Settings mainColor];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.tintColor = Settings.mainColor;
}

@end



