//
//  ViewController.m
//  HiApp
//
//  Created by lijian on 2016/12/18.
//  Copyright © 2016年 lijian. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "LLBootstrap.h"

#define lati 30.676018
#define longti 104.055018

@interface ViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKRadarManagerDelegate>{
    int imageIndexBoy;
    int imageIndexGirl;
    BMKRadarManager *_radarManager;
}

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) UISegmentedControl *MainSegmentControl;
@property (nonatomic, strong) BMKLocationService *locationService;
@property (weak, nonatomic) IBOutlet UIButton *girlBtn;
@property (weak, nonatomic) IBOutlet UIButton *boyBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化按钮
    [_boyBtn bs_configureAsPrimaryStyle];
    [_girlBtn  bs_configureAsSuccessStyle];
    
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
    
    //雷达功能
    _radarManager = [BMKRadarManager getRadarManagerInstance];
    //在不需要时，通过下边的方法使引用计数减1
    [BMKRadarManager releaseRadarManagerInstance];
    
    //2、在上传和拉取位置信息前，需要设置userid，否则会自动生成.设置userid的代码如下：
    _radarManager.userId = @"baidu_mapsdk_radarid";
    
    //启动自动上传用户位置信息,需要实现getRadarAutoUploadInfo获取我的位置信息
    [_radarManager startAutoUpload:5];
    
    //检索四周的用户
    [self searchNearby];
    
}

#pragma mark - 雷达功能

//上传我的位置信息
- (void)uploadPosition {
    
    //构造我的位置信息
    BMKRadarUploadInfo *myinfo = [[BMKRadarUploadInfo alloc] init];
    myinfo.extInfo = @"hello,world";//扩展信息
    myinfo.pt = CLLocationCoordinate2DMake(39.916, 116.404);//我的地理坐标
    //上传我的位置信息
    BOOL res = [_radarManager uploadInfoRequest:myinfo];
    if (res) {
        NSLog(@"upload 成功");
    } else {
        NSLog(@"upload 失败");
    }
}

//周边用户检索
- (void)searchNearby {
    BMKRadarNearbySearchOption *option = [[BMKRadarNearbySearchOption alloc] init]
    ;
    option.radius = 8000;//检索半径
    option.sortType = BMK_RADAR_SORT_TYPE_DISTANCE_FROM_NEAR_TO_FAR;//排序方式
    option.centerPt = CLLocationCoordinate2DMake(39.916, 116.404);//检索中心点
    //发起检索
    BOOL res = [_radarManager getRadarNearbySearchRequest:option];
    if (res) {
        NSLog(@"get 成功");
    } else {
        NSLog(@"get 失败");
    }
}

//实现BMKRadarManagerDelegate回调方法获取结果
- (void)onGetRadarNearbySearchResult:(BMKRadarNearbyResult *)result error:(BMKRadarErrorCode)error {
    NSLog(@"onGetRadarNearbySearchResult  %d", error);
    if (error == BMK_RADAR_NO_ERROR) {
        NSArray *resultInfos = result.infoList;
        //将获取到的结果显示到地图上面
        
        for (BMKRadarNearbyInfo *info in resultInfos) {
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc] init];
            annotation.coordinate = info.pt;
            [_mapView addAnnotation:annotation];
            NSLog(@"附近人的ID ： %@",info.userId);
        }
    }
}


#pragma mark - 添加标注
- (IBAction)addAnnotation:(id)sender {
    
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        
        
        srand((unsigned)time(0));
        double randomLati = rand()%10 * 0.001;
        double randomLong = rand()%10 * 0.001;
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
       
        
        CLLocationCoordinate2D coor;
        coor.latitude = lati+randomLati;
        coor.longitude = longti+randomLong;
        annotation.coordinate = coor;
        annotation.title = @"girl";
        [_mapView addAnnotation:annotation];
   
}

- (IBAction)addBoy:(id)sender {
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        
        srand((unsigned)time(0));
        double randomLati = rand()%10 * 0.001;
        double randomLong = rand()%10 * 0.001;
        
        CLLocationCoordinate2D coor;
        coor.latitude = lati+randomLati;
        coor.longitude = longti+randomLong;
        annotation.coordinate = coor;
        annotation.title = @"boy";
        [_mapView addAnnotation:annotation];
    
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
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        if (imageIndexGirl == 28) {
            imageIndexGirl = 0;
        }
        if (imageIndexBoy == 17) {
            imageIndexBoy = 0;
        }
        
        NSString *imageStr;
        
        //气泡图上面的label
        NSString *paopaoStr = [[NSString alloc] init];
        UILabel * messLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, 130, 60)];
        messLabel.numberOfLines = 0;
        messLabel.font = [UIFont systemFontOfSize:12];
        
        //标注上的label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 130, 40)];
        label.font = [UIFont systemFontOfSize:12];
        
        if ([annotation.title isEqualToString:@"girl"]) {
            imageStr = [NSString stringWithFormat:@"girl%d.jpg",++imageIndexGirl];
            label.text = @" 性别:女\n 状态:单身";
            
            switch (imageIndexGirl) {
                case 1:
                    paopaoStr = @" 其实我并\n 不高冷,只要你\n 肯主动.";
                    break;
                case 2:
                    paopaoStr = @" 我们都是\n熟悉的陌生人.";
                    break;
                case 3:
                    paopaoStr = @" 希望这也\n是一种缘分.";
                    break;
                default:
                    paopaoStr = @" 其实我并\n 不高冷,只要你\n 肯主动.";
                    break;
            }
            
            NSLog(@"%@",imageStr);
        }else if ([annotation.title isEqualToString:@"boy"]) {
            imageStr = [NSString stringWithFormat:@"boy%d.jpg",++imageIndexBoy];
            label.text = @"性别:男\n状态:单身";
            switch (imageIndexBoy) {
                case 1:
                    paopaoStr = @" 我除了帅，实在\n没什么其他的优点\n了！😊";
                    break;
                case 2:
                    paopaoStr = @" 只想找个\n 人一起分享我的\n 喜怒哀乐！😁";
                    break;
                case 3:
                    paopaoStr = @" 希望这也是一种\n缘分.";
                    break;
                default:
                    paopaoStr = @" 找呀找呀\n 找朋友，找到一个\n好朋友!😊";
                    break;
            }
            NSLog(@"%@",imageStr);
        }
        messLabel.text = paopaoStr;
        
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
        [btn setTitle:@"了解更多" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        //[btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(50, 65, 68, 25);
        [btn addTarget:self action:@selector(toKonwDetail) forControlEvents:UIControlEventTouchUpInside];
        
        //关注按钮
        UIButton *attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [attentionBtn bs_configureAsInfoStyle];
        [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        attentionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        attentionBtn.frame = CGRectMake(5, 65, 34, 25);
        [attentionBtn addTarget:self action:@selector(attention) forControlEvents:UIControlEventTouchUpInside];
        
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
        
        UIImage *imageFinally =  [ViewController imageWithView:View];
        
        newAnnotationView.image = imageFinally;
        
        return newAnnotationView;
    }
    
    return nil;
}

#pragma mark - 关注按钮触发事件
-(void)attention
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"关注" message:@"你已关注成功，下次与她(他)相遇时，系统会提醒你哦!😊" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - 了解详情按钮触发事件
-(void)toKonwDetail
{
    //activityDetail
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *dVC = [storyboard instantiateViewControllerWithIdentifier:@"detail"];
    [self presentViewController:dVC animated:YES completion:nil];
}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param view 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    DetailViewController *dVC = [storyboard instantiateViewControllerWithIdentifier:@"detail"];
//    //[self.navigationController pushViewController:dVC animated:YES];
//    [self presentViewController:dVC animated:YES completion:nil];
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



#pragma mark - segment改变是的函数
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg {
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            [self selectedNearby];
            break;
        case 1:
            [self selectedActivity];
            break;
        default:
            break;
    }
    
}

#pragma mark - 选中附近视图
-(void)selectedNearby
{
    
}

#pragma mark - 选中活动视图
-(void)selectedActivity
{
//    for (int i = 0; i<30; i++) {
//        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//        
//        srand((unsigned)time(0));
//        double randomLati = rand()%10 * 0.0001;
//        double randomLong = rand()%10 * 0.0001;
//        
//        CLLocationCoordinate2D coor;
//        coor.latitude = lati+randomLati;
//        coor.longitude = longti+randomLong;
//        annotation.coordinate = coor;
//        annotation.title = @"有谁要来打羽毛球吗？";
//        [_mapView addAnnotation:annotation];
//    }
//    
//    for (int i = 0; i<30; i++) {
//        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//        
//        srand((unsigned)time(0));
//        double randomLati = rand()%10 * 0.0001;
//        double randomLong = rand()%10 * 0.0001;
//        
//        CLLocationCoordinate2D coor;
//        coor.latitude = lati+randomLati;
//        coor.longitude = longti+randomLong;
//        annotation.coordinate = coor;
//        annotation.title = @"谁能帮我取一下快递";
//        [_mapView addAnnotation:annotation];
//    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locationService.delegate = self;
    [_radarManager addRadarManagerDelegate:self];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locationService.delegate = nil;
    [_radarManager removeRadarManagerDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
