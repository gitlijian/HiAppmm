//
//  ActivityDetaiViewController.h
//  HiApp
//
//  Created by lijian on 2017/4/21.
//  Copyright © 2017年 lijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@class ActivityDetaiViewController;// Important
@protocol ActivityDetaiViewControllerDelegate <NSObject>
- (void)addActivityToMap:(ActivityDetaiViewController *)controller didFinishEnteringItem:(NSArray *)activitiesArr;
@end



@interface ActivityDetaiViewController : UIViewController

@property (nonatomic, weak) id <ActivityDetaiViewControllerDelegate>delegate;

@end
