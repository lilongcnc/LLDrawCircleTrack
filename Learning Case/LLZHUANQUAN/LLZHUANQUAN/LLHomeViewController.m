//
//  LLHomeViewController.m
//  LLZHUANQUAN
//
//  Created by 李龙 on 16/9/20.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "LLHomeViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"



@implementation LLHomeViewController{
    NSArray *titleArray;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    titleArray = @[@"1",@"2",@"3",@"4",@"5"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *pushVC;
    switch (indexPath.row) {
        case 0:
            pushVC = [OneViewController new];
            break;
        case 1:
            pushVC = [TwoViewController new];
            break;
        case 2:
            pushVC = [ThreeViewController new];
            break;
        case 3:
            pushVC = [FourViewController new];
            break;
        case 4:
            pushVC = [FiveViewController new];
            break;
        default:
            break;
    }
    
    
    [self.navigationController pushViewController:pushVC animated:YES];
}



@end
