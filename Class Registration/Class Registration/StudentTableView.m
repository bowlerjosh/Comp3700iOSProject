//
//  StudentTableView.m
//  Class Registration
//
//  Created by Josh Carter on 5/2/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "StudentTableView.h"

@interface StudentTableView ()

@property (strong, nonatomic) IBOutlet UITableView *studentTable;

@end

@implementation StudentTableView

@synthesize detailType, dataArray, studentTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Students";
}

-(void)viewWillAppear:(BOOL)animated {
    [studentTable reloadData];
    if ([dataArray count] == 0) {
        UIAlertView *noEntries = [[UIAlertView alloc]initWithTitle:@"Empty" message:@"Your search resulted in no results.\nPlease try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [noEntries show];
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
    
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
    
}

//item pressed
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //determine what was pressed
    NSDictionary *curItem = [dataArray objectAtIndex:indexPath.row];

    //search for class schedule
    if ([detailType isEqualToString:@"ClassSchedule"]) {
        NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"plist"];
        NSDictionary *database = [[NSDictionary alloc] initWithContentsOfFile:plistCatPath];
        NSArray *allClasses = [database objectForKey:@"ClassCatalog"];
        
        NSString *scheduleString = @"Current Schedule:";
        NSArray *scheduleArray = [curItem objectForKey:@"currentClass"];
        for (int i = 0; i < [scheduleArray count]; i ++) {
            NSString *classID = [scheduleArray objectAtIndex:i];
            for (int j = 0; j < [allClasses count]; j++) {
                if ([[[allClasses objectAtIndex:j] objectForKey:@"idNumber"] isEqualToString:classID]) {
                    scheduleString = [NSString stringWithFormat:@"%@\n%@", scheduleString, [[allClasses objectAtIndex:i] objectForKey:@"name"]];
                    break;
                }
            }
        }
        
        UIAlertView *schedule = [[UIAlertView alloc]initWithTitle:@"Class Schedule" message:scheduleString delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
        [schedule show];
    }
    
    //
    else if ([detailType isEqualToString:@"studentGPA"]) {
        NSString *studentGPA = [curItem objectForKey:@"GPA"];
        
        UIAlertView *gpa = [[UIAlertView alloc]initWithTitle:@"Overall GPA" message:studentGPA delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
        [gpa show];
    }
    
    //
    else if ([detailType isEqualToString:@"studentStatus"]) {
        NSString *status = [curItem objectForKey:@"currentStatus"];
        
        UIAlertView *showStatus = [[UIAlertView alloc]initWithTitle:@"Status" message:status delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
        [showStatus show];
    }
    
}

@end
