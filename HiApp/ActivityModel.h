//
//  ActivityModel.h
//  HiApp
//
//  Created by lijian on 2017/5/4.
//  Copyright © 2017年 lijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

//@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *peopleNum;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *ActiviyDescription;
@property (nonatomic, strong) NSString *activityType;

@end
