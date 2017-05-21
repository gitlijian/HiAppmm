//
//  DetailViewController.m
//  HiApp
//
//  Created by lijian on 2017/4/14.
//  Copyright © 2017年 lijian. All rights reserved.
//

#import "DetailViewController.h"
#import "LLBootstrap.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *returnBtn;

@property (weak, nonatomic) IBOutlet UIButton *toDetailBtn;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_returnBtn bs_configureAsSuccessStyle];
    [_toDetailBtn bs_configureAsSuccessStyle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
