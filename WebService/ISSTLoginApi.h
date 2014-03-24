//
//  ISSTLoginApi.h
//  ISST
//
//  Created by XSZHAO on 14-3-23.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "ISSTApi.h"
#import "ISSTWebApiDelegate.h"
@class ISSTApi;
@interface ISSTLoginApi :ISSTApi<NSURLConnectionDataDelegate>

@property (strong, nonatomic)NSMutableData *datas;
@property (nonatomic, assign)id<ISSTWebApiDelegate> webApiDelegate;
- (void)requestLoginName:(NSString *)name andPassword:(NSString *)password;
//- (void)requestUserInfo:(NSString *)user_id;
@end