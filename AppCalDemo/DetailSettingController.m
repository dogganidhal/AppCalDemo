//
//  DetailSettingController.m
//  AppCalDemo
//
//  Created by Nidhal on 06.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "AppsoluteCalendar+AppCalDemo.h"
#import "DetailSettingController.h"
#import "DetailSettingCell.h"
#import "SettingsController.h"
#import "MainTabbarController.h"
#import "FontBook.h"
#import "Settings.h"

@interface DetailSettingController ()

// The index path retrieved from the convenience initializer.
@property (nonatomic, strong) NSIndexPath *senderIndexPath;
// Dictionary holding the object in question.
@property (nonatomic, strong) NSDictionary *selectedObject;
// NSMutableArray with th content of the settings plist file.
@property (nonatomic, strong, readonly) NSMutableArray *plistContent;
// Path to the setting plist file.
@property (nonatomic, strong) NSString *plistFilePath;

@end

@implementation DetailSettingController

#pragma mark - view controller's life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup the logo on the navigation bar
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"AppCalDemo";
    titleLabel.font = [FontBook boldFontOfSize:18];
    titleLabel.textColor = [Settings mainColor];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    // Cusomization
    [self.tableView registerClass:DetailSettingCell.class forCellReuseIdentifier:@"detailSettingCell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    UIEdgeInsets separatorInset = {0};
    separatorInset.left = 8;
    separatorInset.right = 8;
    self.tableView.separatorInset = separatorInset;
    self.navigationController.delegate = self;
    [self setupView];
}

- (void)setupView {
    self.tableView.backgroundColor = Settings.appTheme == ApplicationThemeDark ? [UIColor darkGrayColor] : [UIColor whiteColor];
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
    cell.tintColor = [Settings mainColor];
    if (_senderIndexPath.section != 0) {
        [cell setChecked:((NSNumber *)[_selectedObject objectForKey:@"selectedValue"]).integerValue == indexPath.row];
    } else {
        cell.textLabel.numberOfLines = 3;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_selectedObject objectForKey:@"Title"];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [FontBook regularFontOfSize:16];
    header.textLabel.textColor = [Settings mainColor];
    header.tintColor = Settings.appTheme == ApplicationThemeDark ? [[UIColor whiteColor] colorWithAlphaComponent:0.15] : [UIColor groupTableViewBackgroundColor];
    [header.textLabel sizeToFit];
}

#pragma mark - table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set the mark sign on the selected row
    [_selectedObject setValue:@(indexPath.row) forKey:@"selectedValue"];
    [_plistContent writeToFile:_plistFilePath atomically:YES];
    // Reload data after selecting the row
    [self.tableView reloadData];
    // Update the appearence of the child view controller of the tabbar controller
    MainTabbarController *tabbarController = (MainTabbarController *)self.tabBarController;
    [tabbarController reloadController];
    [tabbarController viewDidLoad];
    [self reloadController];
    [self setupView];
    [AppsoluteCalendar.shared setCustomizationOnCalendar];
    if ([[_selectedObject objectForKey:@"Title"] isEqualToString:@"Theme"]) {
        [UIApplication sharedApplication].statusBarStyle = Settings.appTheme == ApplicationThemeLight ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_senderIndexPath.section == 0 && _senderIndexPath.row == 0) {
        NSString *aboutText = [[_selectedObject objectForKey:@"allValues"] objectAtIndex:0];
        return [self findHeightForText:aboutText havingWidth:self.view.frame.size.width andFont:[FontBook regularFontOfSize:16]] + 16;
    }
    return tableView.rowHeight;
}

#pragma mark - navigation controller delegate methods

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SettingsController *settingsController = (SettingsController *)viewController;
    if (settingsController.class == SettingsController.class) {
        [settingsController reload];
    }
    
}

- (void)reloadController {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"AppCalDemo";
    titleLabel.font = [FontBook boldFontOfSize:18];
    titleLabel.textColor = [Settings mainColor];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.tintColor = Settings.mainColor;
}

- (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGFloat result = font.pointSize + 4;
    if (text) {
        CGSize textSize = { widthValue, CGFLOAT_MAX };       //Width and height of text area
        CGSize size;
        CGRect frame = [text boundingRectWithSize:textSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName:font }
                                          context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height+1);
        result = MAX(size.height, result); //At least one row
    }
    return result;
}


@end




