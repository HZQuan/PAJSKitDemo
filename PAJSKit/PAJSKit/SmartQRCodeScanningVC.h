//  Created by 黄增权 on 18/5/28.
//  Copyright © 2017年 kingsic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SucessCallback)(NSString *qrcodeStr);

@interface SmartQRCodeScanningVC : UIViewController

@property (nonatomic, copy) SucessCallback scanCallback;

@end
