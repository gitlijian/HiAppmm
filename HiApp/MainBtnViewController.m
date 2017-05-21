//
//  MainBtnViewController.m
//  HiApp
//
//  Created by lijian on 2017/4/13.
//  Copyright © 2017年 lijian. All rights reserved.
//

#import "MainBtnViewController.h"
#import "DKCircleButton.h"
#import "ViewController.h"

@interface MainBtnViewController ()
{
    DKCircleButton *button1;
    DKCircleButton *button2;
}
@end

@implementation MainBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    button1 = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    
    button1.center = CGPointMake(160, 200);
    button1.titleLabel.font = [UIFont systemFontOfSize:22];
    
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateSelected];
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateHighlighted];
    
    [button1 setTitle:NSLocalizedString(@"附近", nil) forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(tapOnNearby) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    
    button2 = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    
    button2.center = CGPointMake(160, 350);
    button2.titleLabel.font = [UIFont systemFontOfSize:22];
    
    [button2 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateSelected];
    [button2 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateHighlighted];
    
    [button2 setTitle:NSLocalizedString(@"活动", nil) forState:UIControlStateNormal];
    
    [button2 addTarget:self action:@selector(tapOnActivity) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button2];

}

#pragma mark - 主要按钮点击函数
- (void)tapOnNearby {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ViewController *mapVC = [storyboard instantiateViewControllerWithIdentifier:@"map"];
    [self.navigationController pushViewController:mapVC animated:YES];
    
}

- (void)tapOnActivity {
    
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
