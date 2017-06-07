//
//  DetailSettingController.m
//  AppCalDemo
//
//  Created by Nidhal on 06.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "DetailSettingController.h"
#import "DetailSettingCell.h"
#import "SettingsController.h"
#import "FontBook.h"
#import "Settings.h"

@interface DetailSettingController ()

@property (nonatomic, strong) NSIndexPath *senderIndexPath;
@property (nonatomic, strong) NSDictionary *selectedObject;
@property (nonatomic, strong, readonly) NSMutableArray *plistContent;
@property (nonatomic, strong) NSString *plistFilePath;

@end

@implementation DetailSettingController

#pragma mark - view controller's life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:DetailSettingCell.class forCellReuseIdentifier:@"detailSettingCell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    UIEdgeInsets separatorInset = {0};
    separatorInset.left = 8;
    separatorInset.right = 8;
    self.tableView.separatorInset = separatorInset;
    [self setupView];
}

- (void)setupView {
    self.tableView.backgroundColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
    self.navigationController.delegate = self;
}

#pragma mark - Convenience initializer with indexPath

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath {
    self = [super init];
    if (self) {
        _senderIndexPath = indexPath;
        _plistFilePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
        _plistContent = [NSMutableArray arrayWithContentsOfFile:_plistFilePath];
        [_plistContent writeToFile:_plistFilePath atomically:YES];
        _selectedObject = [[_plistContent objectAtIndex:_senderIndexPath.section] objectAtIndex:_senderIndexPath.row];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray *)[_selectedObject objectForKey:@"allValues"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailSettingCell" forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text = [[_selectedObject objectForKey:@"allValues"] objectAtIndex:indexPath.row];
    cell.textLabel.font = [FontBook regularFontOfSize:16];
    cell.textLabel.textColor = Settings.appTheme == ApplicationThemeDark ? [UIColor whiteColor] : [UIColor blackColor];
    cell.backgroundColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
    cell.tintColor = [UIColor orangeColor];
    [cell setChecked:((NSNumber *)[_selectedObject objectForKey:@"selectedValue"]).integerValue == indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_selectedObject objectForKey:@"Title"];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [FontBook regularFontOfSize:16];
    header.textLabel.textColor = [UIColor orangeColor];
    [header.textLabel sizeToFit];
}

#pragma mark - table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set the mark sign on the selected row
    [_selectedObject setValue:@(indexPath.row) forKey:@"selectedValue"];
    [_plistContent writeToFile:_plistFilePath atomically:YES];
    // Reload data after selecting the row
    [tableView reloadData];
    // If the theme is the object in question apply it immediately
     if ([[_selectedObject objectForKey:@"Title"] isEqualToString:@"Theme"]) {
        [self.navigationController popViewControllerAnimated:YES];
        [UIApplication sharedApplication].statusBarStyle = Settings.appTheme == ApplicationThemeLight ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
         [self.tabBarController viewDidLoad];
     } else if ([[_selectedObject objectForKey:@"Title"] isEqualToString:@"Font"]) {
         [self.tabBarController viewDidLoad];
     }
}

#pragma mark - navigation controller delegate methods

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SettingsController *settingsController = (SettingsController *)viewController;
    if (settingsController.class == SettingsController.class) {
        [settingsController reload];
        
    }
    
}

@end




