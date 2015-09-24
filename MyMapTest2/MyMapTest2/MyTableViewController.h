//
//  MyTableViewController.h
//  MyMapTest2
//
//  Created by 杨 国俊 on 15/9/17.
//  Copyright (c) 2015年 sdzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnnotation.h"
#import "MapViewController.h"
@interface MyTableViewController : UITableViewController

@property(strong,nonatomic) NSMutableArray *annotations;
@property(strong,nonatomic) NSMutableArray *locations;
@end
