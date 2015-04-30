//
//  AllClassesView.m
//  Class Registration
//
//  Created by Josh Carter on 4/29/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "AllClassesView.h"

@interface AllClassesView ()

@property NSArray* allClasses;
@property (strong, nonatomic) IBOutlet UITableView *curTableView;

@end

@implementation AllClassesView
@synthesize allClasses,curTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadDatabase];
}

-(void)viewWillAppear:(BOOL)animated {
    [curTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [allClasses count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    NSDictionary *curItem = [allClasses objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [curItem objectForKey:@"name"];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"Time: %@",[curItem objectForKey:@""],[curItem objectForKey:@"location"], 
    
    return cell;
    
}

-(void)loadDatabase {
    allClasses = [[NSArray alloc]init];
    
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"plist"];
    NSDictionary *database = [[NSDictionary alloc] initWithContentsOfFile:plistCatPath];
    allClasses = [database objectForKey:@"ClassCatalog"];
}

@end
