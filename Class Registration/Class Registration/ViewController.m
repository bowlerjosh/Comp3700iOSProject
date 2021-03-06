//
//  ViewController.m
//  Class Registration
//
//  Created by Josh Carter on 4/29/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "ViewController.h"
#import "UserViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end


@implementation ViewController
@synthesize usernameField, passwordField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDatabase];
}

-(void)viewWillDisappear:(BOOL)animated {
    usernameField.text = @"";
    passwordField.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonPressed:(id)sender {
    NSString *curUsername =  usernameField.text;
    NSString *curPassword = passwordField.text;
    
    //the user type can be a 0, 1, or 2
    // 0 = registrar
    // 1 = instructor
    // 2 = student
    
    //check if login is registrar
    NSArray *registrars = [database objectForKey:@"RegistrarInfo"];
    for (int i = 0; i < [registrars count]; i++) {
        if ([[[[registrars objectAtIndex:i] objectForKey:@"Login"]objectForKey:@"userName"] isEqualToString:curUsername]) {
            //found the login username
            if ([[[[registrars objectAtIndex:i] objectForKey:@"Login"]objectForKey:@"password"] isEqualToString:curPassword]) {
                //correct password
                //log the user in as a registrar
                UserViewController *userIsRegistrar = [[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];
                [userIsRegistrar setUserType:0];
                [userIsRegistrar setCurrentUser:[registrars objectAtIndex:i]];
                [self.navigationController pushViewController:userIsRegistrar animated:YES];
                return;
            }
            else {
                //wrong password, alert user
                passwordField.text = @"";
                UIAlertView *wrongPassword = [[UIAlertView alloc]initWithTitle:@"Wrong Password" message:@"You have entered the wrong password. Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [wrongPassword show];
                
                return;
            }
        }
    }
    
    //check if login is instructor
    NSArray *instructors = [database objectForKey:@"InstructorInfo"];
    for (int i = 0; i < [instructors count]; i++) {
        if ([[[[instructors objectAtIndex:i] objectForKey:@"Login"]objectForKey:@"userName"] isEqualToString:curUsername]) {
            //found the login username
            if ([[[[instructors objectAtIndex:i] objectForKey:@"Login"]objectForKey:@"password"] isEqualToString:curPassword]) {
                //correct password
                //log the user in as a instructor
                UserViewController *userIsInstructor = [[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];
                [userIsInstructor setUserType:1];
                [userIsInstructor setCurrentUser:[instructors objectAtIndex:i]];
                [self.navigationController pushViewController:userIsInstructor animated:YES];
                return;
            }
            else {
                //wrong password, alert user
                passwordField.text = @"";
                UIAlertView *wrongPassword = [[UIAlertView alloc]initWithTitle:@"Wrong Password" message:@"You have entered the wrong password. Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [wrongPassword show];
                
                return;
            }
        }
    }
    
    //check if login is student
    NSArray *students = [database objectForKey:@"StudentInfo"];
    for (int i = 0; i < [students count]; i++) {
        if ([[[[students objectAtIndex:i] objectForKey:@"Login"]objectForKey:@"userName"] isEqualToString:curUsername]) {
            //found the login username
            if ([[[[students objectAtIndex:i] objectForKey:@"Login"]objectForKey:@"password"] isEqualToString:curPassword]) {
                //correct password
                //log the user in as a student
                UserViewController *userIsStudent = [[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];
                [userIsStudent setUserType:2];
                [userIsStudent setCurrentUser:[students objectAtIndex:i]];
                [self.navigationController pushViewController:userIsStudent animated:YES];
                return;
            }
            else {
                //wrong password, alert user
                passwordField.text = @"";
                UIAlertView *wrongPassword = [[UIAlertView alloc]initWithTitle:@"Wrong Password" message:@"You have entered the wrong password. Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [wrongPassword show];
                
                return;
            }
        }
    }
    
    //if you get here the username is not there so alert the user
    usernameField.text = @"";
    passwordField.text = @"";
    UIAlertView *wrongPassword = [[UIAlertView alloc]initWithTitle:@"Username not found." message:@"You have entered a username that is not recognized.\nPlease try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [wrongPassword show];
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
    
    database = [NSMutableDictionary dictionaryWithContentsOfFile:path];
}
@end

