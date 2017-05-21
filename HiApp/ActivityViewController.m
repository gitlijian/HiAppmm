//
//  ActivityViewController.m
//  HiApp
//
//  Created by lijian on 2017/4/16.
//  Copyright © 2017年 lijian. All rights reserved.
//

#import "ActivityViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "MyAnimatedAnnotationView.h"
#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "LLBootstrap.h"
#import "ActivityDetaiViewController.h"
#import "ActivityModel.h"

#define lati 30.676018
#define longti 104.055018

@interface ActivityViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,ActivityDetaiViewControllerDelegate>{
    int imageIndexBoy;
    int imageIndexGirl;
    BMKPointAnnotation* animatedAnnotation;
    BMKPointAnnotation* pointAnnotation;
    BMKPointAnnotation* movieAnnotation;
    BMKPointAnnotation* gongyiAnnotation;
    BMKPointAnnotation* luyingAnnotation;
    BMKPointAnnotation* meishiAnnotation;
    BMKPointAnnotation* yundongAnnotation;
    BMKPointAnnotation* ballSportsAnnotation;
}

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) UISegmentedControl *MainSegmentControl;
@property (nonatomic, strong) BMKLocationService *locationService;

@property (weak, nonatomic) IBOutlet UIButton *virtualActivityBtn;

@property (weak, nonatomic) IBOutlet UIButton *realActivityBtn;
@property (weak, nonatomic) IBOutlet UIButton *sportsBtn;
@property (weak, nonatomic) IBOutlet UIButton *watchMoiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *luyingBtn;
@property (weak, nonatomic) IBOutlet UIButton *meishiBtn;
@property (weak, nonatomic) IBOutlet UIButton *gongyiBtn;
@property (weak, nonatomic) IBOutlet UIButton *ballSportsBtn;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
    //    item.coordinate = (CLLocationCoordinate2D){104.055736, 30.712300};
    //    item.title = @"hi";
    //    [_mapView addAnnotation:item];
    
    //定位
    [self startLocation];
    
    //    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"活动",@"附近",nil];
    //
    //    //初始化UISegmentedControl
    //    _MainSegmentControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    //    _MainSegmentControl.frame = CGRectMake(self.view.center.x-80, 40, 160, 40);
    //    [_MainSegmentControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    
    //[self.view addSubview:_MainSegmentControl];
    
    //初始化按钮
    [_realActivityBtn bs_configureAsPrimaryStyle];
    [_virtualActivityBtn bs_configureAsPrimaryStyle];
    [_luyingBtn bs_configureAsPrimaryStyle];
    [_sportsBtn bs_configureAsPrimaryStyle];
    [_watchMoiveBtn bs_configureAsPrimaryStyle];
    [_meishiBtn bs_configureAsPrimaryStyle];
    [_gongyiBtn bs_configureAsPrimaryStyle];
    [_ballSportsBtn bs_configureAsPrimaryStyle];
    
    [_luyingBtn addTarget:self action:@selector(luyingEvent) forControlEvents:UIControlEventTouchUpInside];
    [_sportsBtn addTarget:self action:@selector(sportsEvent) forControlEvents:UIControlEventTouchUpInside];
    [_watchMoiveBtn addTarget:self action:@selector(watchMoiveEvent) forControlEvents:UIControlEventTouchUpInside];
    [_meishiBtn addTarget:self action:@selector(meishiEvent) forControlEvents:UIControlEventTouchUpInside];
    [_gongyiBtn addTarget:self action:@selector(gongyi) forControlEvents:UIControlEventTouchUpInside];
    [_ballSportsBtn addTarget:self action:@selector(ballSportsEvent) forControlEvents:UIControlEventTouchUpInside];
     
}

#pragma mark - 球类运动按钮事件
-(void)ballSportsEvent
{
    if (ballSportsAnnotation == nil) {
        ballSportsAnnotation = [[BMKPointAnnotation alloc]init];
        
        //产生随机位置
        CLLocationCoordinate2D coor;
        srand((unsigned)time(0));
        double randomLati = rand()%10 * 0.001;
        double randomLong = rand()%10 * 0.001;
        coor.latitude = lati+randomLati;
        coor.longitude = longti+randomLong;
        ballSportsAnnotation.coordinate = coor;
        
        NSString *str = [NSString stringWithFormat:@"有一起去打🏸️的同学吗？"];
        ballSportsAnnotation.title = str;
    }
    [_mapView addAnnotation:ballSportsAnnotation];
}

#pragma mark - 公益按钮事件
-(void)gongyi
{
    if (gongyiAnnotation == nil) {
        gongyiAnnotation = [[BMKPointAnnotation alloc]init];
        
        //产生随机位置
        CLLocationCoordinate2D coor;
        srand((unsigned)time(0));
        double randomLati = rand()%10 * 0.001;
        double randomLong = rand()%10 * 0.001;
        coor.latitude = lati+randomLati;
        coor.longitude = longti+randomLong;
        gongyiAnnotation.coordinate = coor;
        
        NSString *str = [NSString stringWithFormat:@"有暑假去贵州支教的同学吗?"];
        gongyiAnnotation.title = str;
    }
    [_mapView addAnnotation:gongyiAnnotation];

}

#pragma mark - 露营按钮事件
-(void)luyingEvent
{
    if (luyingAnnotation == nil) {
        luyingAnnotation = [[BMKPointAnnotation alloc]init];
        
        //产生随机位置
        CLLocationCoordinate2D coor;
        srand((unsigned)time(0));
        double randomLati = rand()%10 * 0.001;
        double randomLong = rand()%10 * 0.001;
        coor.latitude = lati+randomLati;
        coor.longitude = longti+randomLong;
        luyingAnnotation.coordinate = coor;
        
        NSString *str = [NSString stringWithFormat:@"有去虹口露营的同学吗?"];
        luyingAnnotation.title = str;
    }
    [_mapView addAnnotation:luyingAnnotation];
}

#pragma mark - 运动按钮时间
-(void)sportsEvent
{
    if (yundongAnnotation == nil) {
        yundongAnnotation = [[BMKPointAnnotation alloc]init];
        
        //产生随机位置
        CLLocationCoordinate2D coor;
        srand((unsigned)time(0));
        double randomLati = rand()%10 * 0.001;
        double randomLong = rand()%10 * 0.001;
        coor.latitude = lati+randomLati;
        coor.longitude = longti+randomLong;
        yundongAnnotation.coordinate = coor;
        
        NSString *str = [NSString stringWithFormat:@"有晚上一起🏃的同学吗?"];
        yundongAnnotation.title = str;
    }
    [_mapView addAnnotation:yundongAnnotation];

}

#pragma mark - 看电影按钮事件
-(void)watchMoiveEvent
{
    if (movieAnnotation == nil) {
        movieAnnotation = [[BMKPointAnnotation alloc]init];
        
        //产生随机位置
        CLLocationCoordinate2D coor;
        srand((unsigned)time(0));
        double randomLati = rand()%10 * 0.001;
        double randomLong = rand()%10 * 0.001;
        coor.latitude = lati+randomLati;
        coor.longitude = longti+randomLong;
        movieAnnotation.coordinate = coor;
        
        NSString *str = [NSString stringWithFormat:@"周末看电影有一起的吗?"];
        movieAnnotation.title = str;
    }
    [_mapView addAnnotation:movieAnnotation];
}

#pragma mark - 美食按钮事件
-(void)meishiEvent
{
    if (meishiAnnotation == nil) {
        meishiAnnotation = [[BMKPointAnnotation alloc]init];
        
        //产生随机位置
        CLLocationCoordinate2D coor;
        srand((unsigned)time(0));
        double randomLati = rand()%10 * 0.001;
        double randomLong = rand()%10 * 0.001;
        coor.latitude = lati+randomLati;
        coor.longitude = longti+randomLong;
        meishiAnnotation.coordinate = coor;
        
        NSString *str = [NSString stringWithFormat:@"有一起出去吃🍲的吗?"];
        meishiAnnotation.title = str;
    }
    [_mapView addAnnotation:meishiAnnotation];
    
}

#pragma mark - ActivityDetaiViewControllerDelegate协议中的方法
- (void)addActivityToMap:(ActivityDetaiViewController *)controller didFinishEnteringItem:(NSArray *)activitiesArr
{
    //在该方法里面添加相应的标注
    NSLog(@"数组中%@",activitiesArr);
    
    for (int i=0; i<activitiesArr.count; i++) {
        ActivityModel *model = [[ActivityModel alloc] init];
        model = [activitiesArr objectAtIndex:i];
        
        NSLog(@"%@",model.activityType);
        
        if ([model.activityType isEqualToString:@"露营"]) {
            if (luyingAnnotation == nil) {
                luyingAnnotation = [[BMKPointAnnotation alloc]init];
                
                //产生随机位置
                CLLocationCoordinate2D coor;
                srand((unsigned)time(0));
                double randomLati = rand()%10 * 0.001;
                double randomLong = rand()%10 * 0.001;
                coor.latitude = lati+randomLati;
                coor.longitude = longti+randomLong;
                luyingAnnotation.coordinate = coor;
                
                NSString *str = [NSString stringWithFormat:@"%@ \n时间:%@",model.title,model.time];
                luyingAnnotation.title = str;
            }
            [_mapView addAnnotation:luyingAnnotation];
        }else if ([model.activityType isEqualToString:@"美食"]){
            if (meishiAnnotation == nil) {
                meishiAnnotation = [[BMKPointAnnotation alloc]init];
                
                //产生随机位置
                CLLocationCoordinate2D coor;
                srand((unsigned)time(0));
                double randomLati = rand()%10 * 0.001;
                double randomLong = rand()%10 * 0.001;
                coor.latitude = lati+randomLati;
                coor.longitude = longti+randomLong;
                meishiAnnotation.coordinate = coor;
                
                NSString *str = [NSString stringWithFormat:@"%@ \n时间:%@",model.title,model.time];
                meishiAnnotation.title = str;
            }
            [_mapView addAnnotation:meishiAnnotation];
        }else if ([model.activityType isEqualToString:@"公益"]) {
            if (gongyiAnnotation == nil) {
                gongyiAnnotation = [[BMKPointAnnotation alloc]init];
                
                //产生随机位置
                CLLocationCoordinate2D coor;
                srand((unsigned)time(0));
                double randomLati = rand()%10 * 0.001;
                double randomLong = rand()%10 * 0.001;
                coor.latitude = lati+randomLati;
                coor.longitude = longti+randomLong;
                gongyiAnnotation.coordinate = coor;
                
                NSString *str = [NSString stringWithFormat:@"%@ \n时间:%@",model.title,model.time];
                gongyiAnnotation.title = str;
            }
            [_mapView addAnnotation:gongyiAnnotation];
        } else if ([model.activityType isEqualToString:@"电影"]) {
            if (movieAnnotation == nil) {
                movieAnnotation = [[BMKPointAnnotation alloc]init];
                
                //产生随机位置
                CLLocationCoordinate2D coor;
                srand((unsigned)time(0));
                double randomLati = rand()%10 * 0.001;
                double randomLong = rand()%10 * 0.001;
                coor.latitude = lati+randomLati;
                coor.longitude = longti+randomLong;
                movieAnnotation.coordinate = coor;
                
                NSString *str = [NSString stringWithFormat:@"%@ \n时间:%@",model.title,model.time];
                movieAnnotation.title = str;
            }
            [_mapView addAnnotation:movieAnnotation];
        } else if ([model.activityType isEqualToString:@"运动"]) {
            if (yundongAnnotation == nil) {
                yundongAnnotation = [[BMKPointAnnotation alloc]init];
                
                //产生随机位置
                CLLocationCoordinate2D coor;
                srand((unsigned)time(0));
                double randomLati = rand()%10 * 0.001;
                double randomLong = rand()%10 * 0.001;
                coor.latitude = lati+randomLati;
                coor.longitude = longti+randomLong;
                yundongAnnotation.coordinate = coor;
                
                NSString *str = [NSString stringWithFormat:@"%@ \n时间:%@",model.title,model.time];
                yundongAnnotation.title = str;
            }
            [_mapView addAnnotation:yundongAnnotation];
        }
        
        
    }
}

#pragma mark - 发布真实活动事件
//- (IBAction)addRealActivity:(id)sender {
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ActivityDetaiViewController *dVC = [storyboard instantiateViewControllerWithIdentifier:@"activityDetail"];
//    
//    dVC.delegate = self;
//    
//    [self presentViewController:dVC animated:YES completion:nil];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController * viewController = segue.destinationViewController;
    ActivityDetaiViewController *dVC = (ActivityDetaiViewController *)viewController;
    dVC.delegate = self;
    
}

#pragma mark - 添加动态标注
// 添加动画Annotation
- (void)addAnimatedAnnotation {
    if (animatedAnnotation == nil) {
        animatedAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = 40.115;
        coor.longitude = 116.404;
        animatedAnnotation.coordinate = coor;
        animatedAnnotation.title = @"我是动画Annotation";
    }
    [_mapView addAnnotation:animatedAnnotation];
}

#pragma mark - 添加标注
- (IBAction)addAnnotation:(id)sender {
    
    pointAnnotation = [[BMKPointAnnotation alloc]init];
    

    //        double lastRandomLati = randomLati;
    //        double lastRandomLong = randomLong;
    
    //去重
    //        while (true) {
    //            if (randomLong != lastRandomLong && randomLati != lastRandomLati) break;
    //
    //            srand((unsigned)time(0));
    //            randomLati = rand()%10 * 0.00001;
    //            randomLong = rand()%10 * 0.00001;
    //            lastRandomLati = randomLati;
    //            lastRandomLong = randomLong;
    //        }
    
    srand((unsigned)time(0));
    double randomLati = rand()%10 * 0.001;
    double randomLong = rand()%10 * 0.001;
    CLLocationCoordinate2D coor;
    coor.latitude = lati+randomLati;
    coor.longitude = longti+randomLong;
    pointAnnotation.coordinate = coor;
    pointAnnotation.title = @"girl";
    [_mapView addAnnotation:pointAnnotation];
    
    //添加动态标注
    [self addAnimatedAnnotation];
    
}


#pragma mark - BMKDelegate
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID;
    
    //普通annotation
    if (annotation == pointAnnotation) {
        
        if (imageIndexGirl == 28) {
            imageIndexGirl = 0;
        }
        if (imageIndexBoy == 17) {
            imageIndexBoy = 0;
        }
        
        if (imageIndexGirl == 28) {
            imageIndexGirl = 0;
        }
        if (imageIndexBoy == 17) {
            imageIndexBoy = 0;
        }
        
        NSString *imageStr;
        
        UILabel * messLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, 130, 60)];
        messLabel.numberOfLines = 0;
        messLabel.font = [UIFont systemFontOfSize:12];
        
        //标注上的label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 130, 40)];
        label.font = [UIFont systemFontOfSize:12];
        
        NSString *activityStr = [[NSString alloc] init];
        
        imageStr = [NSString stringWithFormat:@"girl%d.jpg",++imageIndexGirl];
        label.text = @" 性别:女\n 状态:单身";
        
        switch (imageIndexGirl) {
            case 1:
                activityStr = @"周末露营。\n状态:单身";
                break;
            case 2:
                activityStr = @"有🏃的朋友？\n 状态:单身";
                break;
            case 3:
                activityStr = @"有去青城山的\n 朋友吗？\n 状态:单身";
                break;
            case 4:
                activityStr = @"有人要去🏊吗.\n 状态:单身";
                break;
            case 5:
                activityStr = @"有去春熙路的\n 朋友吗？\n 状态:单身";
                break;
            case 6:
                activityStr = @"有一起去图书馆的\n 吗？\n 状态:单身";
                break;
            default:
                activityStr = @" 有一起去欢乐谷的吗？\n 状态:单身";
                break;
        }
        messLabel.text = activityStr;
        
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;  //设置标注动画显示
        
        //自定义泡泡视图，点击下才出现的那个视图
        UIView *paoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 90)];
        
        /*
         加入到文件中之后，一定要加入到工程中之后，才会起作用，重要！
         */
        NSString *whatPaoPaoImgStr = [[NSString alloc] init];
        if ([annotation.title isEqualToString:@"girl"]) {
            whatPaoPaoImgStr = @"msgpaopaoGirl.png";
        }else {
            whatPaoPaoImgStr = @"msgpaopaoBoy.png";
        }
        
        UIImage *img = [UIImage imageNamed:whatPaoPaoImgStr];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        imgView.frame = CGRectMake(0, 0, 100, 80);
        
        [paoView setBackgroundColor:[UIColor clearColor]];
        [imgView setBackgroundColor:[UIColor clearColor]];
        
        //查看详情按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn bs_configureAsInfoStyle];
        [btn setTitle:@"详情" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        //[btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(52, 65, 48, 25);
        [btn addTarget:self action:@selector(toKonwDetail) forControlEvents:UIControlEventTouchUpInside];
        
        //关注按钮
        UIButton *attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [attentionBtn bs_configureAsInfoStyle];
        [attentionBtn setTitle:@"参加" forState:UIControlStateNormal];
        attentionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        attentionBtn.frame = CGRectMake(0, 65, 48, 25);
        [attentionBtn addTarget:self action:@selector(joinActivity) forControlEvents:UIControlEventTouchUpInside];
        
        [imgView addSubview:messLabel];
        [paoView addSubview:imgView];
        [paoView addSubview:btn];
        [paoView addSubview:attentionBtn];
        
        newAnnotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paoView];
        
        //自定义imageView，就是一开始就出现的那个视图
        UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        View.backgroundColor = [UIColor clearColor];
        
        UIImage *ViewBackGroundImg = [UIImage imageNamed:@"Annotationbackground.png"];
        UIImageView *ViewBackGround = [[UIImageView alloc] initWithImage:ViewBackGroundImg];
        ViewBackGround.frame = View.frame;
        [View addSubview:ViewBackGround];
        
        UIImage *image = [UIImage imageNamed:imageStr];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(3, 4.7, 35, 35);
        
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.5;
        
        [View addSubview:imageView];
        
        label.numberOfLines = 0;
        label.textColor  = [UIColor blackColor];
        [View addSubview:label];
        
        [View.layer setOpaque:NO];
        View.opaque = NO;
        
        UIImage *imageFinally =  [ActivityViewController imageWithView:View];
        
        newAnnotationView.image = imageFinally;
        
        return newAnnotationView;
    } else if(annotation == luyingAnnotation) {
        //动画annotation
        AnnotationViewID = @"luyingAnimatedAnnotation";
        MyAnimatedAnnotationView *annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i < 5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"露营%d.png", i]];
            [images addObject:image];
        }
        annotationView.annotationImages = images;
        NSLog(@"生成露营视图");
        return annotationView;
    } else if (annotation == meishiAnnotation) {
        AnnotationViewID = @"meishiAnimatedAnnotation";
        MyAnimatedAnnotationView *annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i < 5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"美食%d.png", i]];
            [images addObject:image];
        }
        annotationView.annotationImages = images;
        NSLog(@"生成美食视图");
        return annotationView;
    } else if (annotation == yundongAnnotation) {
        AnnotationViewID = @"yundongAnimatedAnnotation";
        MyAnimatedAnnotationView *annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i < 5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"运动%d.png", i]];
            [images addObject:image];
        }
        annotationView.annotationImages = images;
        NSLog(@"生成运动视图");
        return annotationView;
    } else if (annotation == movieAnnotation) {
        AnnotationViewID = @"moiveAnimatedAnnotation";
        MyAnimatedAnnotationView *annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i < 5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"电影%d.png", i]];
            [images addObject:image];
        }
        annotationView.annotationImages = images;
        NSLog(@"生成电影视图");
        return annotationView;
    } else if (annotation == gongyiAnnotation) {
        AnnotationViewID = @"gongyiAnimatedAnnotation";
        MyAnimatedAnnotationView *annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i < 5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"公益%d.png", i]];
            [images addObject:image];
        }
        annotationView.annotationImages = images;
        NSLog(@"生成公益视图");
        return annotationView;
    } else if (annotation == ballSportsAnnotation) {
        AnnotationViewID = @"ballSportsAnimatedAnnotation";
        MyAnimatedAnnotationView *annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i < 5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"球%d.png", i]];
            [images addObject:image];
        }
        annotationView.annotationImages = images;
        NSLog(@"生成球类运动视图");
        return annotationView;
    }
    
    //动画annotation
    AnnotationViewID = @"AnimatedAnnotation";
    MyAnimatedAnnotationView *annotationView = nil;
    if (annotationView == nil) {
        annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"poi_%d.png", i]];
        [images addObject:image];
    }
    annotationView.annotationImages = images;
    return annotationView;
    
    return nil;
}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param view 选中的annotation views
 */
//- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    DetailViewController *dVC = [storyboard instantiateViewControllerWithIdentifier:@"activityDetail"];
//    
//    //[self.navigationController pushViewController:dVC animated:YES];
//    [self presentViewController:dVC animated:YES completion:nil];
//}

#pragma mark - 了解详情按钮触发事件
-(void)toKonwDetail
{
    //activityDetail
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *dVC = [storyboard instantiateViewControllerWithIdentifier:@"activityDetail"];
    [self presentViewController:dVC animated:YES completion:nil];
}

#pragma mark - 参加活动事件
-(void)joinActivity
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"关注" message:@"你已报名参加此项活动，请到时候准时参加哦!😊" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 将view转换成image
+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    return img;
}

#pragma mark - 开始定位函数
-(void)startLocation
{
    _locationService = [[BMKLocationService alloc] init];
    [_locationService startUserLocationService];
    
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;//显示定位图层
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locationService.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locationService.delegate = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

