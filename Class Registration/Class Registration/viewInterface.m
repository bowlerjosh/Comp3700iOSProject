//
//  viewInterface.m
//  Class Registration
//
//  Created by Josh Carter on 4/29/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "viewInterface.h"

//views to show
#import "AllClassesView.h"

@interface viewInterface ()

@property (strong, nonatomic) IBOutlet UITableView *curTableView;
@property NSMutableArray *displayArray;

@end

@implementation viewInterface

@synthesize displayArray, curTableView, userType, currentuser;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    displayArray = [[NSMutableArray alloc]init];
    //determine what the user should be allowed to do
    
    //add items that studnets can do since all users will have that power
    [displayArray addObject:@"View All Classes"];
    
    if (userType == 0) {// registrar
        
    }
    else if (userType == 1) {// instructor
        
    }
    
    [curTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [displayArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    cell.textLabel.text = [displayArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

//item pressed
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //determine what was pressed
    NSString *namePressed = [displayArray objectAtIndex:indexPath.row];
    if ([namePressed isEqualToString:@"View All Classes"]) {
        AllClassesView *newView = [[AllClassesView alloc]initWithNibName:@"AllClassesView" bundle:nil];
        [self.navigationController pushViewController:newView animated:YES];
    }
}


@end
