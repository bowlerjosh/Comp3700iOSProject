//
//  FilteredTableView.m
//  Class Registration
//
//  Created by Josh Carter on 5/2/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "FilteredTableView.h"

@interface FilteredTableView ()
@property (strong, nonatomic) IBOutlet UITableView *curTable;


@end

@implementation FilteredTableView

@synthesize curTable, dataArray;

-(void)viewWillAppear:(BOOL)animated {
    [curTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated {
    if ([dataArray count] == 0) {
        UIAlertView *empty = [[UIAlertView alloc]initWithTitle:@"No Results" message:@"Your search resulted in no classes.\nPlease try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [empty show];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    NSDictionary *curItem = [dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [curItem objectForKey:@"name"];
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"Time: %@",[curItem objectForKey:@""],[curItem objectForKey:@"location"],
    
    return cell;
    
}

@end
