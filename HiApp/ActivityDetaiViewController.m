//
//  ActivityDetaiViewController.m
//  HiApp
//
//  Created by lijian on 2017/4/21.
//  Copyright © 2017年 lijian. All rights reserved.
//

#import "ActivityDetaiViewController.h"
#import "LLBootstrap.h"

@interface ActivityDetaiViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *activitiesArray;

@property (weak, nonatomic) IBOutlet UIButton *returnbtn;  //返回按钮
@property (weak, nonatomic) IBOutlet UIButton *publicBtn;  //发布按钮
@property (weak, nonatomic) IBOutlet UIImageView *touXiangImageView; //头像
@property (weak, nonatomic) IBOutlet UITextField *ActivityTilteText; //
@property (weak, nonatomic) IBOutlet UITextField *ActivityTimeText; //活动时间
@property (weak, nonatomic) IBOutlet UITextField *ActivityPeopleNumText; //活动人数
@property (weak, nonatomic) IBOutlet UITextField *ActivityLocationText;  //活动位置
@property (weak, nonatomic) IBOutlet UITextView *ActivityDescriptionText;  //活动描述
@property (weak, nonatomic) IBOutlet UITextField *ActivityTypeText;

@end

@implementation ActivityDetaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_returnbtn bs_configureAsSuccessStyle];
    [_publicBtn bs_configureAsSuccessStyle];
    
    //在使用之前一定要进行初始化，否则不能向里面添加对象（都没在内存中开辟空间，又怎么添加呢？）
    _activitiesArray = [[NSMutableArray alloc] init];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [self.delegate addActivityToMap:self didFinishEnteringItem:_activitiesArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)publicActivityEvent:(id)sender {
    
    //将单个活动加入到活动数组
    ActivityModel *model = [[ActivityModel alloc] init];
    model.title = _ActivityTilteText.text;
    model.time = _ActivityTimeText.text;
    model.peopleNum = _ActivityPeopleNumText.text;
    model.location = _ActivityLocationText.text;
    model.ActiviyDescription = _ActivityDescriptionText.text;
    model.activityType = _ActivityTypeText.text;
    
    [_activitiesArray addObject:model];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"活动" message:@"你已成功在周边发布活动，只需等待感兴趣的小伙伴加入了。😊" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // If the device ahs a camera, take a picture, otherwise,
    // just pick from the photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Put that image onto the screen in our image view
    self.touXiangImageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
