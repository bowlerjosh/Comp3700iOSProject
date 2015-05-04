//
//  SearchInstructorView.m
//  Class Registration
//
//  Created by Josh Carter on 5/3/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "SearchInstructorView.h"
#import "InstructorTableView.h"

@interface SearchInstructorView ()

@property NSArray *allInstructors;
@property (strong, nonatomic) IBOutlet UITextField *instructorName;
@property (strong, nonatomic) IBOutlet UITextField *instructorAccountNumber;

@end

@implementation SearchInstructorView

@synthesize detailToPush, allInstructors, instructorAccountNumber, instructorName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadDatabase];
    self.navigationItem.title = @"Instructor Search";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchPressed:(id)sender {
    NSMutableArray *curCatalog = [[NSMutableArray alloc]init];
    for (int i = 0; i < [allInstructors count]; i++) {
        NSDictionary *curInstructor = [allInstructors objectAtIndex:i];
        
        if ([[curInstructor objectForKey:@"name"] containsString:instructorName.text]) {
            [curCatalog addObject:curInstructor];
        }
        else if ([[curInstructor objectForKey:@"accountNumber"] containsString:instructorAccountNumber.text]) {
            [curCatalog addObject:curInstructor];
        }
    }
    
    InstructorTableView *nextScreen = [[InstructorTableView alloc]initWithNibName:@"InstructorTableView" bundle:nil];
    nextScreen.dataArray = curCatalog;
    nextScreen.detailType = detailToPush;
    [self.navigationController pushViewController:nextScreen animated:YES];
}

-(void)loadDatabase {
    allInstructors = [[NSMutableArray alloc]init];
    
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"plist"];
    NSDictionary *database = [[NSDictionary alloc] initWithContentsOfFile:plistCatPath];
    allInstructors = [database objectForKey:@"InstructorInfo"];
}

@end
