//
//  CreateClass.m
//  Class Registration
//
//  Created by Josh Carter on 5/3/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "CreateClass.h"

@interface CreateClass ()
@property (strong, nonatomic) IBOutlet UITextField *className;
@property (strong, nonatomic) IBOutlet UITextField *classTime;
@property (strong, nonatomic) IBOutlet UITextField *classLocation;
@property (strong, nonatomic) IBOutlet UITextField *classDepartment;
@property (strong, nonatomic) IBOutlet UITextField *classLevel;
@property (strong, nonatomic) IBOutlet UITextField *preRequisiteClassID;
@property (strong, nonatomic) IBOutlet UITextField *capacity;
@property (strong, nonatomic) IBOutlet UITextField *instructorID;

@end

@implementation CreateClass

@synthesize className, classDepartment, classLevel, classLocation, classTime, capacity, instructorID, preRequisiteClassID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain  target:self action:@selector(savePressed)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSDictionary *)loadTopLevel {
    
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:plistCatPath];
}

-(void)savePressed {
    
    if ([className.text isEqualToString:@""] || [classTime.text isEqualToString:@""] || [classLocation.text isEqualToString:@""] || [classDepartment.text isEqualToString:@""] || [capacity.text isEqualToString:@""] || [instructorID.text isEqualToString:@""] ){
        UIAlertView *missing = [[UIAlertView alloc]initWithTitle:@"Missing Info" message:@"Please fill in all required info." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [missing show];
        return;
    }
//    if ([classLevel.text isEqualToString:@""]) {
//        
//    }
    
    NSDictionary *topLevelDatabase = [self loadTopLevel];
    
    //retrieve available id number
    NSString *nextID = [topLevelDatabase objectForKey:@"nextAvailableClassid"];
    
    //verify instructor ID is valid
    NSArray *instructors = [topLevelDatabase objectForKey:@"InstructorInfo"];
    BOOL *found = false;
    for (int i = 0; i < [instructors count]; i++) {
        NSDictionary *curInstructor = [instructors objectAtIndex:i];
        if ([[curInstructor objectForKey:@"accountNumber"] isEqualToString: instructorID.text]) {
            found = true;
            break;
        }
    }
    //if not found, return and give alert
    if (!found) {
        UIAlertView *notFound = [[UIAlertView alloc]initWithTitle:@"Instructor Not Found" message:@"Please verify you have the correct Instructor Info" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [notFound show];
        return;
    }
    
    NSMutableDictionary *newClass = [[NSMutableDictionary alloc]init];
    [newClass setObject:className.text forKey:@"name"];
    [newClass setObject:classTime.text forKey:@"time"];
    [newClass setObject:classLocation.text forKey:@"location"];
    [newClass setObject:nextID forKey:@"idNumber"];
    [newClass setObject:classDepartment.text forKey:@"department"];
    [newClass setObject:classLevel.text forKey:@"level"];
    [newClass setObject:[[NSMutableArray alloc]init] forKey:@"preReqClasses"];
    [newClass setObject:[[NSDictionary alloc]init] forKey:@"Grade"];
    [newClass setObject:capacity.text forKey:@"capacity"];
    [newClass setObject:instructorID.text forKey:@"Instructor"];
    [newClass setObject:[[NSMutableArray alloc]init] forKey:@"StudentsList"];
    
    //save to the database
    [self updateNextClassID];
    [self saveClass:newClass];
}
                        
-(void)updateNextClassID {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database.plist"]; //3
    path = [path stringByAppendingPathComponent:@"database.plist"];
    
    //get top level of database
    NSMutableDictionary* root = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    //add one to classID
    int classID = [[root objectForKey:@"nextAvailableClassid"] intValue];
    classID++;
    NSString *newInt = [NSString stringWithFormat:@"%i",classID];
    [root setObject:newInt forKey:@"nextAvailableClassid"];
    
    //save updated database
    [root writeToFile:path atomically:YES];
}

-(void)saveClass:(NSDictionary *) classIn {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database.plist"]; //3
    
    //get top level of database
    NSDictionary* root = [NSDictionary dictionaryWithContentsOfFile:path];
    NSMutableDictionary *rootMutable = [NSMutableDictionary dictionaryWithDictionary:root];
    
    //add class to ClassCatalog
    NSArray *classCatalog = [root objectForKey:@"ClassCatalog"];
    
    NSMutableArray *curClasses = [NSMutableArray arrayWithArray:classCatalog];
    [curClasses addObject:classIn];
    classCatalog = [NSArray arrayWithArray:curClasses];
    
    [rootMutable setObject:classCatalog forKey:@"ClassCatalog"];
    
    root = [NSDictionary dictionaryWithDictionary:rootMutable];
    
    //save updated database
    [root writeToFile:path atomically:YES];

    [self doneSaving];
}

-(void)doneSaving {
    UIAlertView *done = [[UIAlertView alloc]initWithTitle:@"Done Saving" message:@"Class has been saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [done show];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
