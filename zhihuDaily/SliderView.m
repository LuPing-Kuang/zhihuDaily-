//
//  SliderView.m
//  
//
//  Created by 邝路平 on 16/6/15.
//
//

#import "SliderView.h"
#import "GrandientVIew.h"

@interface SliderView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray<UIImageView*> *imageViews;
@property (nonatomic,assign) NSInteger imageCount;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,assign) NSTimeInterval intervalTimes;
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation SliderView
//延迟实例化
#pragma  mark - 延迟实例化
-(UIScrollView*)scrollView{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        //禁用弹簧效果和滚动条
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.bounces=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.contentMode=UIViewContentModeScaleAspectFill;
        _scrollView.contentSize=CGSizeMake(self.imageCount*self.frame.size.width, self.frame.size.height);
        _scrollView.delegate=self;
    }
    return _scrollView;
}

-(NSMutableArray*)imageViews{
    if (_imageViews==nil) {
        _imageViews=[NSMutableArray array];
    }
    return _imageViews;
}

-(UIPageControl*)pageControl{
    if (_pageControl==nil) {
        _pageControl=[[UIPageControl alloc]init];
        CGSize size=[_pageControl sizeForNumberOfPages:self.imageCount];
        _pageControl.frame=CGRectMake(0, 0, self.frame.size.width, size.height);
        _pageControl.center=CGPointMake(self.frame.size.width/2, self.frame.size.height-15);
        _pageControl.numberOfPages=self.imageCount;
        _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
        _pageControl.pageIndicatorTintColor=[UIColor colorWithWhite:1.0 alpha:0.3];
        
        
    }
    return _pageControl;
}

-(NSInteger)currentIndex{
    return self.scrollView.contentOffset.x/self.frame.size.width;
}


#pragma mark - initialization   

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)buildSliderView{
    [self loadImageViews];
    [self loadContents];
    [self loadButton];
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self bringSubviewToFront:self.pageControl];
    [self startSlidView];
    
}

-(void)loadImageViews{
    for (int i=0; i<self.imageCount; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
        imageView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        //通过代理获取图片
        if ([self.sliderViewDataSource respondsToSelector:@selector(imageAtIndex:)]) {
            UIImage *image=[self.sliderViewDataSource imageAtIndex:i];
            imageView.image=image;
        }
        [self.scrollView addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
}
#warning 蒙板的效果
-(void)loadContents{
    if (![self.sliderViewDataSource respondsToSelector:@selector(titleAtIndex:)]) {
        return;
    }
    for (int i=0; i<self.imageCount; i++) {
        NSString *contents=[self.sliderViewDataSource titleAtIndex:i];
        if (contents==nil) {
            continue;
        }
        GrandientVIew *grandientView=[[GrandientVIew alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        grandientView.gradientLayer.colors=[NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor] ,(id)[UIColor colorWithWhite:0 alpha:0.7], nil];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, grandientView.frame.size.height-70, self.frame.size.width-20, 50)];
        label.text=contents;
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:30 weight:0.3];
        label.shadowOffset=CGSizeMake(0, 1);
        label.shadowColor=[UIColor blackColor];
        label.numberOfLines=2;
        [label sizeToFit];
        
        [grandientView addSubview:label];
        [self.scrollView addSubview:grandientView];
        
        if (![self.sliderViewDataSource respondsToSelector:@selector(subtitleAtIndex:)]) {
            continue;
        }
        NSString *subtitle=[self.sliderViewDataSource subtitleAtIndex:i];
        UILabel *subLabel=[[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x, grandientView.frame.size.height-20, grandientView.frame.size.width-20, 16)];
        subLabel.textColor=[UIColor colorWithWhite:8 alpha:1];
        subLabel.font=[UIFont systemFontOfSize:10];
        subLabel.shadowOffset=label.shadowOffset;
        subLabel.shadowColor=[UIColor colorWithWhite:3 alpha:1];
        subLabel.text=subtitle;
        subLabel.textAlignment=NSTextAlignmentRight;
        [subLabel sizeToFit];
        
        [grandientView addSubview:subLabel];
        
    }
}

-(void)loadButton{
    self.btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
    [self.btn addTarget:self action:@selector(sliderClicked) forControlEvents:UIControlEventTouchUpInside];
    self.btn.titleLabel.text=@"";
    [self.scrollView addSubview:self.btn];
}


#pragma mark add action

-(void)sliderClicked{
    if ([self.sliderViewDataSource respondsToSelector:@selector(touchUpSliderAtIndex:)]) {
        [self.sliderViewDataSource touchUpSliderAtIndex:self.pageControl.currentPage];
    }
}
//添加计时器，以及触发事件
-(void)startSlidView{
    self.intervalTimes=3.0;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:self.intervalTimes target:self selector:@selector(changeContentOffset) userInfo:nil repeats:YES];
}

//用户滑动sliderView，取消滑动事件
-(void)stopSliderView{
    [self.timer invalidate];
    self.timer=nil;
}

//实现无限轮播
-(void)changeContentOffset{
    NSInteger changeIndex=(self.pageControl.currentPage+1)%self.imageCount;
    
    CGFloat offsetx=((self.pageControl.currentPage+1)%self.imageCount)*self.frame.size.width;
    CGPoint offsetPoint=CGPointMake(offsetx, self.scrollView.contentOffset.y);
    self.scrollView.contentOffset=offsetPoint;
    
    [self changePageContolCurrentPage:changeIndex];
    
}

-(void)changePageContolCurrentPage:(NSInteger)Index{
    self.pageControl.currentPage=Index;
}

//代理方法
#pragma mark delegate method
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopSliderView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self startSlidView];
    self.pageControl.currentPage=self.currentIndex;
}





@end
