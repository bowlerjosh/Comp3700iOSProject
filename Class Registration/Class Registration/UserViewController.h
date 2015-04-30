//
//  UserViewController.h
//  Class Registration
//
//  Created by Josh Carter on 4/29/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController {
}

@property int userType;
@property NSDictionary *currentUser;

-(void)setUserType:(int)intIn;

@end
