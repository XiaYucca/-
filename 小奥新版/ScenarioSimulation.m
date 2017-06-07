//
//  ScenarioSimulation.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/6.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "ScenarioSimulation.h"

@interface ScenarioSimulation ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property(nonatomic, weak)IBOutlet UIView *contentView;
@property(nonatomic, weak)IBOutlet UICollectionView *collectionView;

@end

@implementation ScenarioSimulation
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadFromNib];
    }
    return self;
}
-(void)loadFromNib{
    [[NSBundle mainBundle]loadNibNamed:@"ScenarioSimulation" owner:self options:nil];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];

    [self addSubview:_contentView];
}

-(void)awakeFromNib{
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(300, 300);
    //创建collectionView 通过一个布局策略layout来创建
    //UICollectionView * collect = [[UICollectionView alloc]initWithFrame:self.contentView.frame collectionViewLayout:layout];
    
    UICollectionView *collect = self.collectionView;
    collect.collectionViewLayout = layout;
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    //注册item类型 这里使用系统的类型
}


//这是正确的方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    UIImageView *backimageView = [cell viewWithTag:2000];
    UIImageView *imageView = [cell viewWithTag:1000];
    if (!imageView) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 115, 115)];
        backimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 115, 115)];
        
        [cell addSubview:backimageView];
        [cell addSubview:imageView];
        
        backimageView.image = [UIImage imageNamed:@"情景背景.png"];
    }
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",((indexPath.row + indexPath.section * 5)+1)]];
    
    return cell;
}



//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 6;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

////返回每个item
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    return cell;
//}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){115,115};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat dWidth = (self.contentView.frame.size.width - 115 * 4) /5.0;
    return UIEdgeInsetsMake(dWidth*0.5, dWidth * 0.5, dWidth * 0.5, dWidth * 0.5);
}




#pragma mark ---- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
}


// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor grayColor];
    
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
         cell.transform = CGAffineTransformMakeScale( 1.2, 1.2);
    } completion:^(BOOL finished) {
        cell.transform = CGAffineTransformIdentity;
    }];
    [UIView animateWithDuration:0.25 animations:^{
        cell.transform = CGAffineTransformMakeScale( 1.2, 1.2);
    }];
}

// 长按某item，弹出copy和paste的菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 使copy和paste有效
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"])
    {
        return YES;
    }
    return NO;
}




@end
