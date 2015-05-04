//
//  InstructorTableView.m
//  Class Registration
//
//  Created by Josh Carter on 5/3/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "InstructorTableView.h"

@interface InstructorTableView ()
@property (strong, nonatomic) IBOutlet UITableView *instructorTable;

@end

@implementation InstructorTableView

@synthesize detailType, dataArray, instructorTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Instructors";
}

-(void)viewWillAppear:(BOOL)animated {
    [instructorTable reloadData];
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
    if ([detailType isEqualToString:@"instructorReviews"]) {
        
        NSString *scheduleString = @"All Reviews:";
        NSArray *allReviews = [curItem objectForKey:@"reviews"];
        for (int i = 0; i < [allReviews count]; i ++) {
            scheduleString = [NSString stringWithFormat:@"%@\n%@", scheduleString, [allReviews objectAtIndex:i]];
        }
        
        UIAlertView *schedule = [[UIAlertView alloc]initWithTitle:@"All Reviews" message:scheduleString delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
        [schedule show];
    }
    
    //
    else if ([detailType isEqualToString:@"instructorStatus"]) {
        NSString *studentGPA = [curItem objectForKey:@"currentStatus"];
        
        UIAlertView *gpa = [[UIAlertView alloc]initWithTitle:@"Instructor Status" message:studentGPA delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
        [gpa show];
    }
    
    
    
}

@end
