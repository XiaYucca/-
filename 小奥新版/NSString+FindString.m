//
//  NSString+FindString.m
//  googleBlock2.0
//
//  Created by RainPoll on 16/4/14.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

#import "NSString+FindString.h"

@implementation NSString (FindString)


-(NSString *)findStringByPrefixString:(NSString *)preStr SuffixString:(NSString *)sufStr IntervalLength:(int)interval finedContentString:(void (^)(int index , NSString **instanteStr ,bool *stop))callBack
{
    NSMutableString *fromStringM = [self mutableCopy];
    NSRange fixRange = NSMakeRange(0,fromStringM.length);
    int index = 0;
    bool stop = NO;
    while (fixRange.length)  {
        NSRange fileRange = NSMakeRange(0,fromStringM.length);
        fixRange = [fromStringM rangeOfString:preStr options:nil range:NSMakeRange(fixRange.location + 1, fileRange.length - fixRange.location - 1)];
        if (fixRange.length == 0) {
            break;
        }
        NSRange   tempRange = NSMakeRange(fixRange.location + 1, interval);
        NSRange tailRange = [fromStringM rangeOfString:sufStr options:nil range:tempRange];
        if (tailRange.length) {
            NSInteger sufOffset =  sufStr.length;
            if ([sufStr containsString:@"\""]) {
                sufOffset -= 1;
            }
            NSRange tempRange = NSMakeRange(fixRange.location + fixRange.length,tailRange.location - fixRange.location - fixRange.length + sufOffset);
            NSString *subString = [fromStringM substringWithRange:tempRange];
            NSString *instant = [subString copy];
            
            !callBack ? : callBack(index ++, &instant, &stop);
            
            if (stop) {
                return [fromStringM copy];
            }
            if (![instant isEqualToString:subString]) {
                NSLog(@"将%@替换为%@, 位置%@\n",subString,instant,NSStringFromRange(tempRange));
                [fromStringM deleteCharactersInRange:tempRange];
                [fromStringM insertString:instant atIndex:tempRange.location];
                
            }
        }
        
    };
    return [fromStringM copy];
}

// 十六进制转换为普通字符串的。
+(NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

//普通字符串转换为十六进制的。

+ (NSString *)hexStringFromString:(NSString *)string{
    
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


+(NSString *)getHexStringWithData:(NSData *)hexData
{
    
    //    char *myBuffer = (char *)malloc((int)[hexData length] / 2 + 1);
    //    bzero(myBuffer, [hexData length] / 2 + 1);
    NSMutableString *hexString = [@""mutableCopy];
    for (int i = 0; i < [hexData length]; i += 1) {
        unsigned char anInt;
        NSRange range = NSMakeRange(i, 1);
        [hexData getBytes:&anInt range:range];
        ///  NSString * hexCharStr = [hexData substringWithRange:NSMakeRange(i, 2)];
        //  NSScanner * scanner = [[[NSScanner alloc] initWithString:hexCharStr] autorelease];
        //  [scanner scanHexInt:&anInt];
        //        myBuffer[i / 2] = (char)anInt;
        NSString *dataTemp = [NSString stringWithFormat:@"%02x ",anInt];
        [hexString appendString:dataTemp];
    }
    
    //    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    //   NSLog(@"------字符串=======%@",unicodeString);
    return [hexString copy];
}

int InterCode(char* da, int  com,int  cmp)
{
    int x ;char get;
    char *dat=da;
    /* if(com>10){      //如果是字母的话
     if(*dat>'a')x=*dat-'a'+10;
     if(*dat>'A')x=*dat-'A'+10;
     }
     else
     x=0;  //如果是数字的话
     
     if(cmp>10){      //如果是字母的话
     if(*dat>'a')x=*dat-'a'+10;
     if(*dat>'A')x=*dat-'A'+10;
     }*/
    x=0;
    //   printf("%d,%d\n",'a','f');
    
    while(*dat)
    {
        if(com>10)
        {
            if((*dat>='a'&&*dat<='f'))   //对超过16进制的数据单独运算
            {
                get=*dat;              //只能用个参数接收赋值不能直接对*dat赋值操作
                get=get-'a'+10;
                x=x*com+get;
                dat++;}
            else if((*dat>='A'&&*dat<='F'))
            {  get=*dat;
                get=get-'A'+10;
                x=x*com+get;
                dat++;}
            
            else   x=x*com+((*dat++)-'0');    //低于十进制数据直接计算成某进制数据  还是以十进制表示
        }
        else x=x*com+((*dat++)-'0');
    }
    return (int)x;
}


-(void)subStringWithLength:(NSInteger)Length findCallBack:(void(^)(NSString *findData, int index ,bool *stop))callBack
{
    
    NSInteger orgLength = self.length;
    NSRange curRange = NSMakeRange(0, Length);
    
    int index = 0;
    bool stop = NO;
    
    while((orgLength - curRange.location ) > Length) {
        
        NSString *subStr = [self substringWithRange:curRange];
        
        curRange = NSMakeRange(curRange.location + curRange.length , curRange.length);
        
        callBack(subStr ,index ++, &stop);
        
        if (stop) {
            return ;
        }
    }
    
    if((orgLength - curRange.location ) > 0)
    {
        curRange = NSMakeRange(curRange.location,orgLength - curRange.location);
        
        NSString *subData = [self substringWithRange:curRange];
        
        callBack(subData,index ++, &stop);
    }
}








@end
