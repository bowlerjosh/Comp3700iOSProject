//
//  ModificationInterface.m
//  Class Registration
//
//  Created by Josh Carter on 4/29/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "ModificationInterface.h"

#import "FilteredClassView.h"
#import "SearchInstructorView.h"
#import "SearchStudentView.h"

#import "CreateClass.h"
#import "CreateStudent.h"
#import "CreateInstructor.h"
#import "CreateRegistrar.h"

@interface ModificationInterface ()

@property (strong, nonatomic) IBOutlet UITableView *curTableView;
@property NSMutableArray *displayArray;

@end

@implementation ModificationInterface

@synthesize displayArray, curTableView, userType, currentuser;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    displayArray = [[NSMutableArray alloc]init];
    //determine what the user should be allowed to do
    
    //add items that studnets can do since all users will have that power
    
    
    if (userType == 0) {// registrar
        
        [displayArray addObject:@"Add Student to Class"];
        [displayArray addObject:@"Remove Student from Class"];
        
        //classes
        [displayArray addObject:@"Create Class"];
        [displayArray addObject:@"Delete Class"];
        [displayArray addObject:@"Edit Class"];
        
        //students
        [displayArray addObject:@"Create Student"];
        [displayArray addObject:@"Delete Student"];
        [displayArray addObject:@"Edit Student"];
        
        //instructors
        [displayArray addObject:@"Create Instructor"];
        [displayArray addObject:@"Delete Instructor"];
        [displayArray addObject:@"Edit Instructor"];
        
        //registrars
        [displayArray addObject:@"Create Registrar"];
        [displayArray addObject:@"Delete Class"];
        [displayArray addObject:@"Edit Class"];
        
    }
    else if (userType == 1) {// instructor
        [displayArray addObject:@"Register for a Class"];
        [displayArray addObject:@"Drop a Class"];
    }
    else if (userType == 2) {// student
        
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
    if ([namePressed isEqualToString:@"Add Student to Class"]) {
        SearchStudentView *nextView = [[SearchStudentView alloc]initWithNibName:@"SearchInstructorView" bundle:nil];
        nextView.detailToPush = @"addStudentToClass";
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
//    [displayArray addObject:@"Remove Student from Class"];
    else if ([namePressed isEqualToString:@"Remove Student from Class"]) {
        SearchStudentView *nextView = [[SearchStudentView alloc]initWithNibName:@"SearchInstructorView" bundle:nil];
        nextView.detailToPush = @"removeStudentFromClass";
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
//    [displayArray addObject:@"Create Class"];
    else if ([namePressed isEqualToString:@"Create Class"]) {
        CreateClass *nextView = [[CreateClass alloc]initWithNibName:@"CreateClass" bundle:nil];
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
//    [displayArray addObject:@"Delete Class"];
    else if ([namePressed isEqualToString:@"Delete Class"]) {
        FilteredClassView *nextView = [[FilteredClassView alloc]initWithNibName:@"FilteredClassView" bundle:nil];
        nextView.detailToPush = @"deleteClass";
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
//    [displayArray addObject:@"Edit Class"];
    else if ([namePressed isEqualToString:@"Edit Class"]) {
        FilteredClassView *nextView = [[FilteredClassView alloc]initWithNibName:@"FilteredClassView" bundle:nil];
        nextView.detailToPush = @"editClass";
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
//    [displayArray addObject:@"Create Student"];
    else if ([namePressed isEqualToString:@"Create Student"]) {
        CreateStudent *nextView = [[CreateStudent alloc]initWithNibName:@"CreateStudent" bundle:nil];
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
//    [displayArray addObject:@"Delete Student"];
    else if ([namePressed isEqualToString:@"Delete Student"]) {
        SearchStudentView *nextView = [[SearchStudentView alloc]initWithNibName:@"SearchInstructorView" bundle:nil];
        nextView.detailToPush = @"deleteStudent";
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
//    [displayArray addObject:@"Edit Student"];
    else if ([namePressed isEqualToString:@"Edit Student"]) {
        SearchStudentView *nextView = [[SearchStudentView alloc]initWithNibName:@"SearchInstructorView" bundle:nil];
        nextView.detailToPush = @"editStudent";
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
//    [displayArray addObject:@"Create Instructor"];
    else if ([namePressed isEqualToString:@"Create Instructor"]) {
        CreateInstructor *nextView = [[CreateInstructor alloc]initWithNibName:@"CreateInstructor" bundle:nil];
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
//    [displayArray addObject:@"Delete Instructor"];
    else if ([namePressed isEqualToString:@"Delete Instructor"]) {
        
    }
    
//    [displayArray addObject:@"Edit Instructor"];
    else if ([namePressed isEqualToString:@"Edit Instructor"]) {
        
    }
    
//    [displayArray addObject:@"Create Registrar"];
    else if ([namePressed isEqualToString:@"Create Registrar"]) {
        CreateRegistrar *nextView = [[CreateRegistrar alloc]initWithNibName:@"CreateRegistrar" bundle:nil];
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
//    [displayArray addObject:@"Delete Class"];
    else if ([namePressed isEqualToString:@"Delete Class"]) {
        
    }
    
//    [displayArray addObject:@"Edit Class"];
    else if ([namePressed isEqualToString:@"Edit Class"]) {
        
    }
    
}

@end
