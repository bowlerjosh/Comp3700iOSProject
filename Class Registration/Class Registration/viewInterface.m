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
#import "FilteredClassView.h"
#import "SearchStudentView.h"
#import "SearchInstructorView.h"

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
    
    //add items that all users can do
    [displayArray addObject:@"View All Classes"];
    [displayArray addObject:@"View Filtered Classes"];
    
    if (userType == 0) {// registrar
        [displayArray addObject:@"View Student Class Schedule"];
        [displayArray addObject:@"View Student GPA"];
        [displayArray addObject:@"View Student Status"];
        [displayArray addObject:@"View Instructor Reviews"];
        [displayArray addObject:@"View Instructor Status"];
    }
    else if (userType == 1) {// instructor
        [displayArray addObject:@"View All Reviews"];
        [displayArray addObject:@"View Current Status"];
    }
    else {//student
//        [displayArray addObject:@"View Eligible Classes"];
        [displayArray addObject:@"View Registration Status"];
        [displayArray addObject:@"View Class Schedule"];
        [displayArray addObject:@"View GPA"];
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
    
    //all available to these
    if ([namePressed isEqualToString:@"View All Classes"]) {
        AllClassesView *newView = [[AllClassesView alloc]initWithNibName:@"AllClassesView" bundle:nil];
        [self.navigationController pushViewController:newView animated:YES];
    }
    else if ([namePressed isEqualToString:@"View Filtered Classes"]) {
        FilteredClassView *detail = [[FilteredClassView alloc]initWithNibName:@"FilteredClassView" bundle:nil];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    //registrar only
//        [displayArray addObject:@"View Student Class Schedule"];
    else if ([namePressed isEqualToString:@"View Student Class Schedule"]) {
        SearchStudentView *nextView = [[SearchStudentView alloc]initWithNibName:@"SearchStudentView" bundle:nil];
        nextView.detailToPush = @"ClassSchedule";
        [self.navigationController pushViewController:nextView animated:YES];
    }
//        [displayArray addObject:@"View Student GPA"];
    else if ([namePressed isEqualToString:@"View Student GPA"]) {
        //studentGPA
        SearchStudentView *nextView = [[SearchStudentView alloc]initWithNibName:@"SearchStudentView" bundle:nil];
        nextView.detailToPush = @"studentGPA";
        [self.navigationController pushViewController:nextView animated:YES];
    }
//        [displayArray addObject:@"View Student Status"];
    else if ([namePressed isEqualToString:@"View Student Status"]) {
        //studentStatus
        SearchStudentView *nextView = [[SearchStudentView alloc]initWithNibName:@"SearchStudentView" bundle:nil];
        nextView.detailToPush = @"studentStatus";
        [self.navigationController pushViewController:nextView animated:YES];
    }
//        [displayArray addObject:@"View Instructor Reviews"];
    else if ([namePressed isEqualToString:@"View Instructor Reviews"]) {
        SearchInstructorView *nextView = [[SearchInstructorView alloc]initWithNibName:@"SearchInstructorView" bundle:nil];
        nextView.detailToPush = @"instructorReviews";
        [self.navigationController pushViewController:nextView animated:YES];
    }
//        [displayArray addObject:@"View Instructor Status"];
    else if ([namePressed isEqualToString:@"View Instructor Status"]) {
        SearchInstructorView *nextView = [[SearchInstructorView alloc]initWithNibName:@"SearchInstructorView" bundle:nil];
        nextView.detailToPush = @"instructorStatus";
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
    // instructor only
//        [displayArray addObject:@"View All Reviews"];
    else if ([namePressed isEqualToString:@"View All Reviews"]) {
        AllClassesView *newView = [[AllClassesView alloc]initWithNibName:@"AllClassesView" bundle:nil];
        [self.navigationController pushViewController:newView animated:YES];
    }
//        [displayArray addObject:@"View Current Status"];
    else if ([namePressed isEqualToString:@"View Current Status"]) {
        AllClassesView *newView = [[AllClassesView alloc]initWithNibName:@"AllClassesView" bundle:nil];
        [self.navigationController pushViewController:newView animated:YES];
    }
    
    //student only
//        [displayArray addObject:@"View Eligible Classes"];
    else if ([namePressed isEqualToString:@"View Eligible Classes"]) {
#warning To do
    }
//        [displayArray addObject:@"View Registration Status"];
    else if ([namePressed isEqualToString:@"View Registration Status"]) {
        NSString *statusString = [currentuser objectForKey:@"currentStatus"];
        UIAlertView *status = [[UIAlertView alloc]initWithTitle:@"Registration Status" message:statusString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [status show];
    }
//        [displayArray addObject:@"View Class Schedule"];
    else if ([namePressed isEqualToString:@"View Class Schedule"]) {
        NSArray *curSchedule = [currentuser objectForKey:@"currentClass"];
        NSString *scheduleString = @"Schedule: ";
        for (int i = 0; i < [curSchedule count]; i++) {
            scheduleString = [NSString stringWithFormat:@"%@\n%@", scheduleString, [curSchedule objectAtIndex:i]];
        }
        UIAlertView *status = [[UIAlertView alloc]initWithTitle:@"Current Schedule" message:scheduleString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [status show];
    }
//        [displayArray addObject:@"View Transcript"];
    else if ([namePressed isEqualToString:@"View GPA"]) {
        NSString *statusString = [currentuser objectForKey:@"GPA"];
        UIAlertView *status = [[UIAlertView alloc]initWithTitle:@"Current GPA" message:statusString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [status show];
    }
    
}

-(NSDictionary *)loadDatabase {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"plist"]; //5
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    
    //get top level of database
    
    return [NSDictionary dictionaryWithContentsOfFile:path];
}
@end
