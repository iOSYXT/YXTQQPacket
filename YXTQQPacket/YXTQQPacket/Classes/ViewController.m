//
//  ViewController.m
//  YXTQQPacket
//
//  Created by 杨小童 on 16/7/2.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *qqPacketTableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *onOrOffArray;

@end

@implementation ViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.titleArray = [NSArray array];
        self.sectionArray = [NSArray array];
        self.onOrOffArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.titleArray = @[@"家人组", @"同事组", @"同学组", @"朋友组", @"邻居组", @"陌生人组"];
    
    self.sectionArray = @[
                          @[@"家人A", @"家人B", @"家人C", @"家人D"],
                          @[@"同事A", @"同事B"],
                          @[@"同学A", @"同学B", @"同学C"],
                          @[@"朋友A", @"朋友B", @"朋友C", @"朋友D"],
                          @[@"邻居A", @"邻居B", @"邻居C", @"邻居D", @"邻居E", @"邻居F", @"邻居G", @"邻居H"],
                          @[@"陌生人A"]
                          ];
    self.onOrOffArray = [NSMutableArray arrayWithObjects:@0, @0, @0, @0, @0, @0, nil];
    
    self.qqPacketTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
    self.qqPacketTableView.dataSource = self;
    self.qqPacketTableView.delegate = self;
    [self.view addSubview:self.qqPacketTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    headerLabel.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:241 / 255.0 blue:242 / 255.0 alpha:1.0f];
    headerLabel.tag = section;
    headerLabel.text = [NSString stringWithFormat:@"    %@", self.titleArray[section]];
    headerLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesClick:)];
    [headerLabel addGestureRecognizer:ges];
    [headerView addSubview:headerLabel];
    
    return headerView;
}

- (void)gesClick:(UITapGestureRecognizer *)ges
{

#pragma mark - 点击任意一个关闭的分组，关闭其他分组
    if ([self.onOrOffArray[ges.view.tag] isEqual:@0]) {
        
        for (int i = 0; i < self.onOrOffArray.count; i++) {
            
            [self.onOrOffArray replaceObjectAtIndex:i withObject:@0];
            [self.qqPacketTableView reloadSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        [self.onOrOffArray replaceObjectAtIndex:ges.view.tag withObject:@1];
        
    } else {
        
        [self.onOrOffArray replaceObjectAtIndex:ges.view.tag withObject:@0];
    }
    
    [self.qqPacketTableView reloadSections:[NSIndexSet indexSetWithIndex:ges.view.tag] withRowAnimation:UITableViewRowAnimationFade];
    
//#pragma mark - 点击任意一个展开的分组，关闭这个分组
//    if ([self.onOrOffArray[ges.view.tag] isEqual:@0]) {
//        
//        [self.onOrOffArray replaceObjectAtIndex:ges.view.tag withObject:@1];
//        
//    } else {
//        
//        [self.onOrOffArray replaceObjectAtIndex:ges.view.tag withObject:@0];
//    }
//    
//    [self.qqPacketTableView reloadSections:[NSIndexSet indexSetWithIndex:ges.view.tag] withRowAnimation:UITableViewRowAnimationFade];
    
#pragma mark - 点击任意一个展开的分组，收回全部已展开的分组
//    if ([self.onOrOffArray[ges.view.tag] isEqual:@0]) {
//        
//        [self.onOrOffArray replaceObjectAtIndex:ges.view.tag withObject:@1];
//        
//        [self.qqPacketTableView reloadSections:[NSIndexSet indexSetWithIndex:ges.view.tag] withRowAnimation:UITableViewRowAnimationFade];
//        
//    } else {
//        
//        for (int i = 0; i < self.onOrOffArray.count; i++) {
//            
//            [self.onOrOffArray replaceObjectAtIndex:i withObject:@0];
//            [self.qqPacketTableView reloadSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationFade];
//        }
//        
//    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.onOrOffArray[section] isEqual:@0]) {
        
        return 0;
    }
    return [self.sectionArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"qqPacket";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text = self.sectionArray[indexPath.section][indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
