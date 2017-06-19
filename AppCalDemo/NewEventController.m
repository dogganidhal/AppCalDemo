//
//  NewEventController.m
//  AppCalDemo
//
//  Created by Nidhal on 09.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

#import "NewEventController.h"

@interface NewEventController ()

@end

@implementation NewEventController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submitNewEvent)];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %ld", section];
}

- (void)submitNewEvent {
    NSLog(@"Submit");
}

@end
