//
//  MyTableViewController.m
//  MyMapTest2
//
//  Created by 杨 国俊 on 15/9/17.
//  Copyright (c) 2015年 sdzy. All rights reserved.
//

#import "MyTableViewController.h"
/*
 泰州科技学院
 119.939618,32.465027
 泰州学院
 119.935456,32.466004
 江苏农牧学院
 119.94473,32.45875
 泰州人民公园
 119.923078,32.459721
 */
@interface MyTableViewController ()

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self loadData];
    
  //  NSLog(@"%@",self.annotations);
}

-(void)loadData
{
    self.annotations=[NSMutableArray array];
    self.navigationItem.title=@"信息列表";
    
    MyAnnotation *annotion1=[[MyAnnotation alloc] init];
    annotion1.coordinate=CLLocationCoordinate2DMake(32.465027, 119.939618);
    annotion1.title=@"泰州科技学院";
    annotion1.subtitle=@"iOS尚承实验室";
    annotion1.annotationImage=[UIImage imageNamed:@"tky.png"];
    
    [self.annotations addObject:annotion1];
    
    self.locations=[NSMutableArray array];
    MKPointAnnotation *tzxy=[[MKPointAnnotation alloc] init];
    tzxy.coordinate=CLLocationCoordinate2DMake(32.466004,119.935456);
    tzxy.title=@"泰州学院";
    tzxy.subtitle=@"东风南路109号";
    [self.locations addObject:tzxy];
    
    MKPointAnnotation *jsmy=[[MKPointAnnotation alloc] init];
    jsmy.coordinate=CLLocationCoordinate2DMake(32.45875,119.94473);
    jsmy.title=@"江苏农牧学院";
    jsmy.subtitle=@"春晖路5-1号";
    [self.locations addObject:jsmy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    if (section==0) {
        return self.annotations.count;
    }
    else if (section==1){
        return self.locations.count;
    }
    else{
    return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        MyAnnotation *annotion=[self.annotations objectAtIndex:indexPath.row];
        cell.textLabel.text=annotion.title;
        cell.detailTextLabel.text=annotion.subtitle;
        cell.imageView.image=annotion.annotationImage;
        return cell;
    }
    else if (indexPath.section==1)
    {
        MKPointAnnotation *location=[self.locations objectAtIndex:indexPath.row];
        cell.textLabel.text=location.title;
        cell.detailTextLabel.text=location.subtitle;
        return cell;
    }
    else
    {
        cell.textLabel.text=@"地点汇总";
        cell.detailTextLabel.text=@" 所有位置都在这里";
     return cell;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"邻居列表";
    }
    else if (section==1)
    {
        return @"地标列表";
    }
    else
    {
        return @"其他";
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // NSLog(@"did");
    MapViewController *mapViewController=[[MapViewController alloc] init];
   
    if (indexPath.section==0) {
        MyAnnotation *annotation=[self.annotations objectAtIndex:indexPath.row];
        mapViewController.annotations=@[annotation];
    }
    else if (indexPath.section==1)
    {
        MKPointAnnotation *annotation=[self.locations objectAtIndex:indexPath.row];
        mapViewController.annotations=@[annotation];
    }
    else
    {
        NSMutableArray *all=[NSMutableArray array];
        [all addObjectsFromArray:self.annotations];
        [all addObjectsFromArray:self.locations];
        NSArray *allannotation=[all copy];
        mapViewController.annotations=allannotation;
    }
    
    [self.navigationController pushViewController:mapViewController animated:YES];
}


@end
