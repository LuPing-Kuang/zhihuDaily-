//
//  MainViewController.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/12.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "MainViewController.h"
#import "URLRequest.h"
#import "MBProgressHUD.h"
#import "DataSource.h"
#import "GrandientVIew.h"


@interface MainViewController ()
@property (nonatomic,strong)DataSource *dataSource;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataSource newsLatest:^(BOOL needsToReload) {
        NSLog(@"已经可以使用了");
        
    }];
//    self.view.backgroundColor=[UIColor whiteColor];
//    UIImageView*iamgeView=[[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
//    iamgeView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
//    [self.view addSubview:iamgeView];
//    NSLog(@"------color,%@",iamgeView.backgroundColor);
    
    UIPageControl* pageControl=[[UIPageControl alloc]init];
    CGSize size=[pageControl sizeForNumberOfPages:5];
    pageControl.backgroundColor=[UIColor blueColor];
    pageControl.frame=CGRectMake(0, 0, self.view.frame.size.width, size.height);
    pageControl.numberOfPages=5;
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    pageControl.pageIndicatorTintColor=[UIColor orangeColor];
    [self.view addSubview:pageControl];
    pageControl.center = CGPointMake(self.view.center.x, self.view.center.y - 15);
//    self.view.backgroundColor=[UIColor redColor];
//    UILabel* label = [[UILabel alloc]
//                      initWithFrame:CGRectMake(50, 100,
//                                               200, 50)];
//    label.textColor = [UIColor colorWithWhite:1 alpha:1];
//    label.font = [UIFont systemFontOfSize:50 weight:0.3];
//    label.shadowOffset = CGSizeMake(0, -1);
//    label.shadowColor = [UIColor blackColor];
//    label.numberOfLines = 3;
//    label.text =@"使克林顿将发生纠纷";
//    //由于label的文字是垂直居中，在单行时需要调用该方法适配
//    [label sizeToFit];
// 
//    [self.view addSubview:label];
//    NSLog(@"%.4f",2.0/3.0);
    UIWebView *webView=[[UIWebView alloc]init];

}



-(DataSource*)dataSource{
    if (_dataSource==nil) {
        _dataSource=[[DataSource alloc]init];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"--------%lu",self.dataSource.stories.count);
    return self.dataSource.stories.count;
   
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text=[self.dataSource.stories[indexPath.row] title];
    cell.textLabel.textColor=[UIColor orangeColor];
    cell.textLabel.text=@"可以使用";
    return cell;
}



@end
