//
//  DrawLine.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "DrawLine.h"
#import "NSMutableArray+Queue.h"

#define IS_NEAR 30

//@interface NodeList : Node()
//@property (nonatomic ,assign)Node *head;
//@property (nonatomic ,assign)Node *tail;
//@property (nonatomic ,assign)NSInteger nodeNum;
//@property (nonatomic ,strong)NSMutableArray *nodeLifeManage;
//
//
//@end

//
// 写算法最难看的语言->oc
//

@implementation Node

+(instancetype)createNodeWithPoint:(CGPoint)point
{
    Node *temp = [[Node alloc]init];
    if (temp) {
        temp.point  =point;
    }
    return temp;
}

+(instancetype)createNodeWithPoint:(CGPoint)point withNext:(Node *)next
{
    Node *temp = [[Node alloc]init];
    if (temp) {
        temp.point  = point;
        temp.next = next;
    }
    return temp;
}


+(instancetype)createNodeWithNext:(Node *)next{
    Node *temp= [[Node alloc]init];
    if (temp) {
        temp.next = next;
    }
    return temp;
}

//判断第一个在 一定范围里面的节点
-(Node *)findNearNodeByPoint:(CGPoint)point
{
    Node *temp = self;
    while (temp) {
        if ([temp nodeIsNear:point withRadius:IS_NEAR]) {
            break;
        }else
        {
        temp = temp.next;
        }
    }
    return temp;
}

// 遍历线中最近的节点
-(Node *)findNearestNodeByPoint:(CGPoint)point {
    Node *temp = self;
    CGFloat smallLength = MAXFLOAT;
    Node *nearest = temp;
    while (temp) {
        CGFloat length = [self lengthPointFromPoint:temp.point toPoint:point];
        if (length < smallLength) {
            smallLength = length;
            nearest = temp;
        }
        temp = temp.next;
    }
    return nearest;
}

//判断及诶单是否在距离之内
-(BOOL)nodeIsNear:(CGPoint)point withRadius:(CGFloat)radius
{
    CGFloat f = powf(point.x - self.point.x, 2);
    f = f + powf(point.y  - self.point.y, 2);
    CGFloat r = powf(radius, 2);
    if (f < r) {
        return  YES;
    }
    return NO;
}

//两点之间的距离
-(CGFloat)lengthPointFromPoint:(CGPoint)fromP toPoint:(CGPoint)toP
{
    return sqrtf(powf(fromP.x - toP.x,2) + powf( fromP.y - toP.y, 2));
}

/********  list  *********/

-(Node *)tailNode{
    Node *temp = self;
    while (temp.next) {
        temp = temp.next;
    }
    return temp;
}

-(Node *)appendNode:(Node *)node{
    Node *temp = [self tailNode];
    temp.next = node;
    return self;
}

@end




@implementation NodeList

+(instancetype)nodeList{
    NodeList *tmp = [[NodeList alloc]init];
    if (tmp) {
        tmp.head = tmp.tail = nil;
        tmp.nodeNum = 0;
        tmp.nodeLifeManage = [NSMutableArray array];
    }
    return tmp;
}

//创建列表并且制定头节点
-(instancetype)createNodeListWithHead:(Node *)head{
    NodeList *temp = [[NodeList alloc]init];
    if (temp) {
        self.nodeLifeManage = [NSMutableArray array];
        temp.head = head;
        temp.tail = head;
        self.nodeNum = 1;
        [_nodeLifeManage push:head];
    }
    return temp;
}
// 在列表尾部追加node
-(void)appendNode:(Node *)node{
    
    if (self.head == nil && !self.nodeNum) {
        self.head = node;
    }
    
    if (node) {
        self.tail.next = node;
        self.tail = node;
        [self.nodeLifeManage push:node];
        node.index = self.nodeNum;
        self.nodeNum += 1;
        
    }else{
        NSLog(@"warning node is nil");
    }
}

//每个列表中的node
-(void)enumerateNodesUsingBlock:(void(^)(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop))block{
    
    for (int i = 0; i < self.nodeLifeManage.count; i ++) {
        id temp = [self.nodeLifeManage objectAtIndex:i];
        BOOL stop = NO;
        if (block) {
            block(temp ,i,& stop);
            if (stop) {
                return;
            }
        }
    }
}
// 创建列表到头部 返回列表
-(instancetype)creatNodeListByStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint insertNum:(NSInteger)num{
    NSArray *arr = [self insertNodefromPoint:startPoint toPoint:endPoint withCount:num];
    NodeList *temp = [[NodeList alloc]createNodeListWithHead:[Node createNodeWithPoint:startPoint]];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            NSValue *value = (NSValue *) obj;
            [temp appendNode:[Node createNodeWithPoint:value.CGPointValue]];
        }
    }];
    return temp;
}

// 添加列表到list 尾部
-(void)appenList:(NodeList *)list{
    if (list.nodeNum) {
        [list enumerateNodesUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self appendNode:obj];
        }];
    }else{
        NSLog(@"list node is too short");
    }
    
}


//node层面关系
// 连点之间差值
-(NSArray *)insertNodefromPoint:(CGPoint)fromP toPoint:(CGPoint)toP withLength:(CGFloat)length
{
    CGFloat orlength = [self lengthPointFromPoint:fromP toPoint:toP];
    NSInteger count = floor(orlength / length);
    
    NSArray *arr = [NSMutableArray array];
    arr = [self insertNodefromPoint:fromP toPoint:toP withCount:count];
    return arr;
    
}


//node层面关系
///插入节点指定位置
//两点之间插值 参数是count
-(NSArray *)insertNodefromPoint:(CGPoint)fromP toPoint:(CGPoint)toP withCount:(NSInteger)count
{
    CGFloat orlength = [self lengthPointFromPoint:fromP toPoint:toP];
    
    count = count +1;
    CGFloat stepX = (toP.x - fromP.x)/count;
    CGFloat stepY = (toP.y - fromP.y)/count;
    
    CGPoint tempPoint = fromP;
    
    NSMutableArray *arr = [NSMutableArray array];

    for (int i= 0 ; i < count+1 ; i++) {
        tempPoint = CGPointMake(fromP.x + stepX * i, fromP.y + stepY * i);
        [arr addObject: [NSValue valueWithCGPoint:tempPoint]];
    }
    return [arr copy];
}

//剪切line 于指定位置
-(NSArray *)cutNodeListAtIndex:(NSUInteger)index
{
    if (index >= self.nodeNum || index < 0) {
        NSLog(@"error out of range line nodes array");
        return nil;
    }
    Node * temp = [self.nodeLifeManage objectAtIndex:index-1];
    
    Node *newHead = temp.next;
    self.tail = temp;
    temp.next = nil;
    
    NSMutableArray *arrFull = self.nodeLifeManage;
    int count = arrFull.count - index ;

    NSArray *newLifeManage = [arrFull subarrayWithRange:NSMakeRange(index, count)];
    NodeList *newList = [NodeList nodeList];
    
    [newLifeManage enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [newList appendNode:obj];
    }];
    
    self.nodeLifeManage = [[arrFull subarrayWithRange:NSMakeRange(0, index)] mutableCopy];
    self.nodeNum = self.nodeLifeManage.count;
    
    NSArray *result = [NSArray arrayWithObjects:self,newList, nil];
    return  result;
}

//连接测试 将第二list 连接到第一个list 返回第一个list对象
-(NodeList *)connectLineFromLine:(NodeList *)fromList toLine:(NodeList *)toLine
{
    NSArray *arr = [self insertNodefromPoint:fromList.tail.point toPoint:toLine.head.point withCount:10];
    
    for (int i =0; i < arr.count; i++) {
        id obj = arr[i];
        Node *temp = [Node createNodeWithPoint: ((NSValue *)obj).CGPointValue];
        [fromList appendNode:temp];
    }
    [fromList appenList:toLine];
    return fromList;
}

////返回
//-(NSUInteger)indexAtNodeList:(Node *)node{
//    NSUInteger index = 0;
//    
//    Node *temp = self.head;
//    
//    while(temp){
//        if(temp == node || [node nodeIsNear:temp.point withRadius:IS_NEAR]){
//            return index;
//        }
//        index ++;
//        temp = temp.next;
//    }
//    return INT_MAX;
//}

//返回最近节点的索引
-(NSInteger)nearestAtNodeList:(Node *)node{
    
    Node *temp = [self.head findNearestNodeByPoint:node.point];
    BOOL isNear = [temp nodeIsNear:node.point withRadius:IS_NEAR];
    if (isNear) {
        return temp.index;
    }
    else return  -1;
}

// 剪切距离 最近的节点分割line
-(NSArray *)cutNodeListAtNode:(Node *)node{
    return [self cutNodeListAtIndex:[self nearestAtNodeList:node]];
}




@end


@implementation DrawLine

@end














