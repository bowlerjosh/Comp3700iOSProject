//
//  SearchStudentView.m
//  Class Registration
//
//  Created by Josh Carter on 5/2/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "SearchStudentView.h"
#import "StudentTableView.h"

@interface SearchStudentView ()

@property NSArray *allStudents;
@property (strong, nonatomic) IBOutlet UITextField *studentName;
@property (strong, nonatomic) IBOutlet UITextField *studentAccountNumber;
@property (strong, nonatomic) IBOutlet UITextField *studentLevel;

@end

@implementation SearchStudentView

@synthesize detailToPush, allStudents, studentAccountNumber, studentLevel, studentName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadDatabase];
    self.navigationItem.title = @"Student Search";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchPressed:(id)sender {
    NSMutableArray *curCatalog = [[NSMutableArray alloc]init];
    for (int i = 0; i < [allStudents count]; i++) {
        NSDictionary *curClass = [allStudents objectAtIndex:i];
        
        if ([[curClass objectForKey:@"name"] containsString:studentName.text]) {
            [curCatalog addObject:curClass];
        }
        else if ([[curClass objectForKey:@"accountNumber"] containsString:studentAccountNumber.text]) {
            [curCatalog addObject:curClass];
        }
        else if ([[curClass objectForKey:@"level"] containsString:studentLevel.text]) {
            [curCatalog addObject:curClass];
        }
    }
    
    StudentTableView *nextScreen = [[StudentTableView alloc]initWithNibName:@"StudentTableView" bundle:nil];
    nextScreen.dataArray = curCatalog;
    nextScreen.detailType = detailToPush;
    [self.navigationController pushViewController:nextScreen animated:YES];
}

-(void)loadDatabase {
    allStudents = [[NSMutableArray alloc]init];
    
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"plist"];
    NSDictionary *database = [[NSDictionary alloc] initWithContentsOfFile:plistCatPath];
    allStudents = [database objectForKey:@"StudentInfo"];
}

@end
