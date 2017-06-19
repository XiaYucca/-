//
//  Route.m
//  RouteModeCode
//
//  Created by ZhuJX on 16/8/23.
//  Copyright © 2016年 ZhuJX. All rights reserved.
//

#import "Route.h"
@implementation Route

static BOOL isPushVc;

+(Route*)share{
    static Route * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[Route alloc] init];
    });
    return manager;
}

-(void)GoToControllerIsPush:(BOOL)isPush ClassName:(NSString*)calssName From:(UIViewController*)fromVc PropertyDic:(NSDictionary*)propertyDic{
    UIViewController * controller = [[NSClassFromString(calssName) alloc] init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if(propertyDic){
            for(NSString * propertyNameStr in [propertyDic allKeys]){
                [controller setValue:[propertyDic objectForKey:propertyNameStr] forKey:propertyNameStr];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            isPushVc = isPush;
            
            if(isPush == YES){
                [fromVc.navigationController pushViewController:controller animated:YES];
            }else{
                [fromVc presentViewController:controller animated:YES completion:nil];
            }
        });
    });
}

-(void)GoBackFromController:(UIViewController *)controller{
    if(isPushVc == YES){
        [controller.navigationController popViewControllerAnimated:YES];
    }else{
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
