//
//  CreateRegistrar.m
//  Class Registration
//
//  Created by Josh Carter on 5/3/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "CreateRegistrar.h"

@interface CreateRegistrar ()
@property (strong, nonatomic) IBOutlet UITextField *registrarName;
@property (strong, nonatomic) IBOutlet UITextField *loginName;
@property (strong, nonatomic) IBOutlet UITextField *loginPassword;
@property (strong, nonatomic) IBOutlet UITextField *initialStatus;

@end

@implementation CreateRegistrar

@synthesize registrarName, loginName, loginPassword, initialStatus;

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
    
    if ([registrarName.text isEqualToString:@""] || [loginName.text isEqualToString:@""] || [loginPassword.text isEqualToString:@""] || [initialStatus.text isEqualToString:@""] ){
        UIAlertView *missing = [[UIAlertView alloc]initWithTitle:@"Missing Info" message:@"Please fill in all required info." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [missing show];
        return;
    }
    //    if ([classLevel.text isEqualToString:@""]) {
    //
    //    }
    
    NSDictionary *topLevelDatabase = [self loadTopLevel];
    
    //retrieve available id number
    NSString *nextID = [topLevelDatabase objectForKey:@"nextAvailableAccountNumber"];
    
    NSMutableDictionary *login = [[NSMutableDictionary alloc]init];
    [login setObject:loginName.text forKey:@"userName"];
    [login setObject:loginPassword.text forKey:@"password"];
    
    NSMutableDictionary *newStudent = [[NSMutableDictionary alloc]init];
    [newStudent setObject:registrarName.text forKey:@"name"];
    [newStudent setObject:nextID forKey:@"accountNumber"];
    [newStudent setObject:login forKey:@"Login"];
    [newStudent setObject:initialStatus.text forKey:@"currentStatus"];
    
    
    //save to the database
    [self updateNextAccountID];
    [self saveRegistrar:newStudent];
}

-(void)updateNextAccountID {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database.plist"]; //3
    path = [path stringByAppendingPathComponent:@"database.plist"];
    
    //get top level of database
    NSMutableDictionary* root = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    //add one to classID
    int classID = [[root objectForKey:@"nextAvailableAccountNumber"] intValue];
    classID++;
    NSString *newInt = [NSString stringWithFormat:@"%i",classID];
    [root setObject:newInt forKey:@"nextAvailableAccountNumber"];
    
    //save updated database
    [root writeToFile:path atomically:YES];
}

-(void)saveRegistrar:(NSDictionary *) studentIn {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database.plist"]; //3
    
    //get top level of database
    NSDictionary* root = [NSDictionary dictionaryWithContentsOfFile:path];
    NSMutableDictionary *rootMutable = [NSMutableDictionary dictionaryWithDictionary:root];
    
    //add class to ClassCatalog
    NSArray *classCatalog = [root objectForKey:@"RegistrarInfo"];
    
    NSMutableArray *curClasses = [NSMutableArray arrayWithArray:classCatalog];
    [curClasses addObject:studentIn];
    classCatalog = [NSArray arrayWithArray:curClasses];
    
    [rootMutable setObject:classCatalog forKey:@"RegistrarInfo"];
    
    root = [NSDictionary dictionaryWithDictionary:rootMutable];
    
    //save updated database
    [root writeToFile:path atomically:YES];
    
    [self doneSaving];
}

-(void)doneSaving {
    UIAlertView *done = [[UIAlertView alloc]initWithTitle:@"Done Saving" message:@"Student has been saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [done show];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
