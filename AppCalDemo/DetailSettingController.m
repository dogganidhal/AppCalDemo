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

@interface DetailSettingController ()

@property (nonatomic, strong) NSIndexPath *senderIndexPath;
@property (nonatomic, strong) NSDictionary *selectedObject;
@property (nonatomic, strong, readonly) NSMutableArray *plistContent;
@property (nonatomic, strong) NSString *plistFilePath;

@end

@implementation DetailSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appTheme = [[[NSUserDefaults standardUserDefaults] stringForKey:@"theme"] isEqualToString:@"light"] ? ApplicationThemeLight : ApplicationThemeDark;
    [self.tableView registerClass:DetailSettingCell.class forCellReuseIdentifier:@"detailSettingCell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    UIEdgeInsets separatorInset = {0};
    separatorInset.left = 8;
    separatorInset.right = 8;
    self.tableView.separatorInset = separatorInset;
    self.navigationController.delegate = self;
}

#pragma mark - Designated initializer to get the exact piece of setting to show

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
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
    cell.textLabel.textColor = _appTheme == ApplicationThemeDark ? [UIColor whiteColor] : [UIColor blackColor];
    cell.backgroundColor = _appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
    cell.accessoryType = ((NSNumber *)[_selectedObject objectForKey:@"selectedValue"]).integerValue == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_selectedObject setValue:@(indexPath.row) forKey:@"selectedValue"];
    [_plistContent writeToFile:_plistFilePath atomically:YES];
    [tableView reloadData];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SettingsController *settingsController = (SettingsController *)viewController;
    if (settingsController.class == SettingsController.class) {
        [settingsController reload];
    }
}

@end




