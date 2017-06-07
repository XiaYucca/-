//
//  ____Tests.m
//  小奥新版Tests
//
//  Created by RainPoll on 2017/4/18.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DrawLine.h"



@interface ____Tests : XCTestCase

@end

@implementation ____Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void)testConnect{
    NodeList *list = [NodeList nodeList];
    for (int i = 0; i < 10; i ++) {
        [list appendNode:[Node createNodeWithPoint:CGPointMake(i,0)]];
    }
    NodeList *list_2 = [NodeList nodeList];
    for (int i = 0; i < 10; i ++) {
        [list_2 appendNode:[Node createNodeWithPoint:CGPointMake(i,1)]];
    }
    //测试连接
    [list connectLineFromLine:list toLine:list_2];
    
    
    //测试定点范围剪切
    Node *node = [Node createNodeWithPoint:CGPointMake(5.5, 1)];

    NSArray *arr =  [list cutNodeListAtNode:node];
    arr;
}


-(void)X_testLine{

    NodeList *list = [NodeList nodeList];
    NSLog(@"%@",list);
    
    int i = 0;
    for (int i = 0; i < 10; i ++) {
        [list appendNode:[Node createNodeWithPoint:CGPointMake(i,0)]];
    }
    NSLog(@"%@",list);
    
    NodeList *list_2 = [NodeList nodeList];
    NSLog(@"%@",list_2);
    
    for (int i = 0; i < 10; i ++) {
        [list_2 appendNode:[Node createNodeWithPoint:CGPointMake(i,1)]];
    }
    NSLog(@"%@",list_2);
    
    [list appenList: list_2];
    NSLog(@"listAppend:%@",list);
    [list enumerateNodesUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"index %ld ,obj:%@",idx,NSStringFromCGPoint(((Node*)obj).point));
    }];
    
    NSArray *arr = [list cutNodeListAtIndex:8];
    NSLog(@"%@",arr[0]);
    NSLog(@"%@",arr[1]);
    
    NodeList *r1 = arr[0];
    NodeList *r2 = arr[1];
    
    for (int i= 0; i < r1.nodeLifeManage.count; i ++) {
        Node *nod = r1.nodeLifeManage[i];
        NSLog(@"index %ld ,obj:%@",i,NSStringFromCGPoint(nod.point));
    }
    
    NSLog(@"\n\n\n");
    
    for (int i= 0; i < r2.nodeLifeManage.count; i ++) {
        Node *nod = r2.nodeLifeManage[i];
        NSLog(@"index %ld ,obj:%@",i,NSStringFromCGPoint(nod.point));
    }
    
    NSLog(@"\n\n\n");
    
    Node *head = r1.head;
    while (head) {
        NSLog(@"obj:%@",NSStringFromCGPoint(head.point));
        head = head.next;
    }
    

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
