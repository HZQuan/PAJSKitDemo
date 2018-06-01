//
//  SmartCoreLocationKit.m
//  PAJSKit
//
//  Created by 黄增权 on 2018/5/31.
//  Copyright © 2018年 comg.pinganzhihuichengshi. All rights reserved.
//

#import "SmartCoreLocationKit.h"

@interface SmartCoreLocationKit()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation SmartCoreLocationKit

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static SmartCoreLocationKit *kit;
    dispatch_once(&onceToken, ^{
        kit = [[SmartCoreLocationKit alloc] init];
    });
    return kit;
}

//开始定位
- (void)startLocationWithBridge:(WVJBResponseCallback )responseCallback {
    self.responseCallback = responseCallback;
    if ([CLLocationManager locationServicesEnabled]) {
        //        CLog(@"--------开始定位");
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.responseCallback) {
        self.responseCallback(@{@"errorCode":@"40000",@"errorMessage":@"定位失败"});
    }
    if ([error code] == kCLErrorDenied) {
        
    }
    if ([error code] == kCLErrorLocationUnknown) {
    }
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            NSString *country = placemark.country;
            NSString *province = placemark.administrativeArea;
            NSString *city = placemark.locality;
            NSString  *district = placemark.subLocality;
            NSString *street = placemark.name;
            NSString *address = [NSString stringWithFormat:@"%@%@%@",city,district,street];
            NSArray *arearArray = @[country,province,city,district,street,address];
            for (int i = 0; i < arearArray.count; i++) {
                NSString *arear = [arearArray objectAtIndex:i];
                if (arear.length == 0) {
                    arear = @"";
                }
            }
            //获取城市
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            if (self.responseCallback) {
                self.responseCallback(@{@"accuracy":@(10),@"address":address,@"country":country,@"province":province,@"city":city,
                                        @"district":district,@"street":street
                                        });
            }
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}



@end
