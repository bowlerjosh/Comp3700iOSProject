//
//  StudentTableView.h
//  Class Registration
//
//  Created by Josh Carter on 5/2/15.
//  Copyright (c) 2015 Josh Carter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentTableView : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property NSString *detailType;
@property NSMutableArray *dataArray;

@end
