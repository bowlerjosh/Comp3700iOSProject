//
//  FilteredClassView.m
//  Class Registration
//
//  Created by Josh Carter on 4/30/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "FilteredClassView.h"
#import "FilteredTableView.h"

@interface FilteredClassView ()
@property NSMutableArray *allClasses;
@property (strong, nonatomic) IBOutlet UITextField *className;
@property (strong, nonatomic) IBOutlet UITextField *classTime;
@property (strong, nonatomic) IBOutlet UITextField *classLocation;
@property (strong, nonatomic) IBOutlet UITextField *classID;
@property (strong, nonatomic) IBOutlet UITextField *classDepartment;
@property (strong, nonatomic) IBOutlet UITextField *classLevel;
@property (strong, nonatomic) IBOutlet UITextField *classInstructor;

@end

@implementation FilteredClassView

@synthesize allClasses, className, classTime, classLocation, classID, classDepartment, classLevel, classInstructor;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"View Filtered Classes";
    // Do any additional setup after loading the view from its nib.
    [self loadDatabase];
}

-(void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchPressed:(id)sender {
    NSMutableArray *curCatalog = [[NSMutableArray alloc]init];
    for (int i = 0; i < [allClasses count]; i++) {
        NSDictionary *curClass = [allClasses objectAtIndex:i];
        
        if ([[curClass objectForKey:@"name"] containsString:className.text]) {
            [curCatalog addObject:curClass];
        }
        else if ([[curClass objectForKey:@"time"] containsString:classTime.text]) {
            [curCatalog addObject:curClass];
        }
        else if ([[curClass objectForKey:@"location"] containsString:classLocation.text]) {
            [curCatalog addObject:curClass];
        }
        else if ([[curClass objectForKey:@"idNumber"] containsString:classID.text]) {
            [curCatalog addObject:curClass];
        }
        else if ([[curClass objectForKey:@"department"] containsString:classDepartment.text]) {
            [curCatalog addObject:curClass];
        }
        else if ([[curClass objectForKey:@"level"] containsString:classLevel.text]) {
            [curCatalog addObject:curClass];
        }
        else if ([[curClass objectForKey:@"Instructor"] containsString:classInstructor.text]) {
            [curCatalog addObject:curClass];
        }
    }
    
    FilteredTableView *nextScreen = [[FilteredTableView alloc]initWithNibName:@"FilteredTableView" bundle:nil];
    nextScreen.dataArray = curCatalog;
    [self.navigationController pushViewController:nextScreen animated:YES];
}


-(void)loadDatabase {
    
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
    
    allClasses = [[NSMutableDictionary dictionaryWithContentsOfFile:path] objectForKey:@"ClassCatalog"];
}

@end
