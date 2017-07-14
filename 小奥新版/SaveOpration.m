//
//  SaveOpration.m
//  小奥新版
//
//  Created by RainPoll on 2017/6/9.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "SaveOpration.h"
#import "SaveOprationCell.h"
#import "PlayRecordViewCell.h"

@interface SaveOpration ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,weak)IBOutlet UIView *view;

@property (nonatomic ,weak)IBOutlet UITableView *tableView;
@end


@implementation SaveOpration
{
    CGFloat testHight;
    
    NSMutableDictionary *selectedIndexes;
  //  - (BOOL)cellIsSelected:(NSIndexPath *)indexPath;
    
    NSInteger tableViewSections;
    NSInteger tableViewRow;
    BOOL isOpen;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initFromNib];
}

-(void)initFromNib{
    //测试数据
    [self test];
    
    [[NSBundle mainBundle]loadNibNamed:@"SaveOpration" owner:self options:nil];
    [self addSubview:self.view];
    [self.tableView registerNib:[UINib nibWithNibName:@"SaveOprationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SaveOprationCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayRecordViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PlayRecordViewCell"];
}

-(void)test{
    
    testHight = 50;
    selectedIndexes = [NSMutableDictionary dictionary];
    
    tableViewSections = 1;
    tableViewRow = 10;
    isOpen = NO;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initFromNib];
    }
    return self;
}

-(IBAction)cansoleBtnClick{
    [[self class] dissmissOnWindow:nil];
}

+(void)dissmissOnWindow:(void (^)(bool))complient{
    bool isFound = NO;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    for (id temp in [window subviews]) {
        if ([temp isKindOfClass:NSClassFromString(@"SaveOpration") ]) {
        //  NSLog(@"find ConnectView will remove from window%@",temp);
            [((SaveOpration *)temp) removeFromSuperview];
            isFound = YES;
        }
    }
    !complient? : complient(isFound);
}


+(void)showOnWindow:(void (^)(void))complient{
    SaveOpration *temp = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //动画
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    //    [window addSubview:temp];
    [window insertSubview:temp atIndex:window.subviews.count];
    [window bringSubviewToFront:temp];
    //     [temp initFromNib];
    !complient ? :complient();
}


#pragma mark -tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewRow;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tableViewSections;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //SaveOprationCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"SaveOprationCell" forIndexPath:indexPath];
    

    SaveOprationCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"SaveOprationCell" forIndexPath:indexPath];
    return cell;
   
  //  return cell;
}



//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section ==0 ) {
//        return testHight;
//    }
//    return 100;
//}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    XLog(@"index_section:%ld row:%ld",indexPath.section,indexPath.row);
//
//    
//}





- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
    // Return whether the cell at the specified index path is selected or not
    NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
    return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

//设置行高

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //return 35;
    if ([self cellIsSelected:indexPath]) {
        return 90;
    }
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect cell
   [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    // Toggle 'selected' state
    BOOL isSelected = ![self cellIsSelected:indexPath];
    // Store cell 'selected' state keyed on indexPath
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [selectedIndexes setObject:selectedIndex forKey:indexPath];
    
    //
//  This is where magic happens...
    [self.tableView beginUpdates];
    
    NSInteger      section            = indexPath.section;
    NSMutableArray *rowToInsert       = [[NSMutableArray alloc]init];
    NSIndexPath    *indexPathToInsert = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:section];
    [rowToInsert addObject:indexPathToInsert];
    
//   [tableView moveRowAtIndexPath:indexPath toIndexPath:indexPathToInsert];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIView *view = [cell viewWithTag:100];
    
    if (isSelected) {
//        tableViewRow ++;
//        [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        if (view) {
            view.hidden = NO;
        }
        
    } else {
//        tableViewRow --;
//        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        view.hidden = YES;
    }
    [self.tableView endUpdates];
}


@end
