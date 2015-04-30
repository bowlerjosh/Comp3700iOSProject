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
                [userIsStudent setCurrentUser:[registrars objectAtIndex:i]];
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
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"plist"];
    
    database = [[NSDictionary alloc] initWithContentsOfFile:plistCatPath];
}


/*
 example code used to overwrite a plist
 -(void)setFavorite {
 [self didRegisterwithChannel];
 
 //save the favorite to the app memory
 NSFileManager *fileManager = [NSFileManager defaultManager];
 NSError *error;
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0];
 
 NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"favorites.plist"];
 
 NSMutableDictionary *curSchool = [[NSMutableDictionary alloc]init];
 NSDictionary *curManifest = manifest;
 NSString *curID = [curManifest objectForKey:@"id"];
 NSString *curName = [curManifest objectForKey:@"name"];
 [curSchool setObject:curID forKey:@"id"];
 [curSchool setObject:curName forKey:@"name"];
 
 if ([fileManager fileExistsAtPath:plistPath] == NO) {
 NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"favorites" ofType:@"plist"];
 [fileManager copyItemAtPath:resourcePath toPath:plistPath error:&error];
 NSMutableDictionary* plist = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
 int numSchools = [plist count];
 NSString *curNum = [NSString stringWithFormat:@"%i",numSchools];
 [plist setObject:curSchool forKey:curNum];
 [plist writeToFile:plistPath atomically:YES];
 }
 else {
 NSMutableDictionary* plist = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
 int numSchools = [plist count];
 NSString *curNum = [NSString stringWithFormat:@"%i",numSchools];
 [plist setObject:curSchool forKey:curNum];
 [plist writeToFile:plistPath atomically:YES];
 }
 
 //
 //favoriteButton = [[UIButton alloc]initWithFrame:CGRectMake(45, 100-45, 45, 45)];
 UIImage *btnImage = [UIImage imageNamed:@"selStar.png"];
 [favoriteButton setImage:btnImage forState:UIControlStateNormal];
 [favoriteButton addTarget:self action:@selector(setUnFavorite) forControlEvents:UIControlEventTouchUpInside];
 }
 */

@end

