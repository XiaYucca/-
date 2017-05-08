//
//  Route.h
//  RouteModeCode
//
//  Created by ZhuJX on 16/8/23.
//  Copyright © 2016年 ZhuJX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Route : NSObject
+(Route*)share;
-(void)GoToControllerIsPush:(BOOL)isPush ClassName:(NSString*)calssName From:(UIViewController*)fromVc PropertyDic:(NSDictionary*)propertyDic;
-(void)GoBackFromController:(UIViewController*)controller;


@end
