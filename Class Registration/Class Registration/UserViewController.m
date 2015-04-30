//
//  UserViewController.m
//  Class Registration
//
//  Created by Josh Carter on 4/29/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import "UserViewController.h"

#import "viewInterface.h"
#import "ModificationInterface.h"

@interface UserViewController ()
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userTypeLabel;

@end

@implementation UserViewController

@synthesize userType, currentUser, userNameLabel, userTypeLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    userNameLabel.text = [NSString stringWithFormat:@"Welcome %@",[currentUser objectForKey:@"name"]];
    if (userType == 0) {
        userTypeLabel.text = @"Registrar Account";
    }
    else if (userType == 1) {
        userTypeLabel.text = @"Instructor Account";
    }
    else if (userType == 2) {
        userTypeLabel.text = @"Student Account";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//the user type can be a 0, 1, or 2
// 0 = registrar
// 1 = instructor
// 2 = student

- (IBAction)viewInformationPressed:(id)sender {
    viewInterface *newOnly = [[viewInterface alloc]initWithNibName:@"viewInterface" bundle:nil];
    newOnly.currentuser = currentUser;
    newOnly.userType = userType;
    [self.navigationController pushViewController:newOnly animated:YES];
}

- (IBAction)modifyPressed:(id)sender {
    ModificationInterface *newOnly = [[ModificationInterface alloc]initWithNibName:@"ModificationInterface" bundle:nil];
    newOnly.currentuser = currentUser;
    newOnly.userType = userType;
    [self.navigationController pushViewController:newOnly animated:YES];
}

@end
