//
//  DrawLine.h
//  小奥新版
//
//  Created by RainPoll on 2017/6/5.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject
//点的坐标是什么;
@property (nonatomic ,assign)CGPoint point;
//点的下一个节点是
@property (nonatomic ,weak)Node * _Nullable next;
@property (nonatomic ,assign)NSUInteger index;

//-(instancetype)createNodeWithNext:(Node *)next;

+(instancetype)createNodeWithPoint:(CGPoint)point;
+(instancetype)createNodeWithPoint:(CGPoint)point withNext:(Node *)next;
+(instancetype)createNodeWithNext:(Node *)next;
//判断第一个在 一定范围里面的节点
-(Node *)findNearNodeByPoint:(CGPoint)point;
// 遍历线中最近的节点
-(Node *)findNearestNodeByPoint:(CGPoint)point;
//判断及诶单是否在距离之内
-(BOOL)nodeIsNear:(CGPoint)point withRadius:(CGFloat)radius;
//两点之间的距离
-(CGFloat)lengthPointFromPoint:(CGPoint)fromP toPoint:(CGPoint)toP;
-(Node *)tailNode;
-(Node *)appendNode:(Node *)node;

@end



@interface DrawLine : NSObject

@end


@interface NodeList : Node
@property (nonatomic ,assign)Node *head;
@property (nonatomic ,assign)Node *tail;
@property (nonatomic ,assign)NSInteger nodeNum;
@property (nonatomic ,strong)NSMutableArray *nodeLifeManage;

+(instancetype)nodeList;
-(instancetype)createNodeListWithHead:(Node *)head;
-(void)appendNode:(Node *)node;
-(void)enumerateNodesUsingBlock:(void(^)(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop))block;

-(instancetype)creatNodeListByStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint insertNum:(NSInteger)num;
-(void)appenList:(NodeList *)list;

-(NSArray *)cutNodeListAtIndex:(NSUInteger)index;
-(NSArray *)cutNodeListAtNode:(Node *)node;

//连接线段
-(NodeList *)connectLineFromLine:(NodeList *)fromList toLine:(NodeList *)toLine;

-(NSInteger)nearestAtNodeList:(Node *)node;



@end


