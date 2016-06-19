//
//  SliderView.h
//  
//
//  Created by 邝路平 on 16/6/15.
//
//

#import <UIKit/UIKit.h>

@protocol sliderViewDelegat <NSObject>

@required

-(NSInteger)numberOfItemsInSliderView;

-(UIImage*)imageAtIndex:(NSInteger)index;

-(NSString*)titleAtIndex:(NSInteger)index;

-(NSString*)subtitleAtIndex:(NSInteger)index;

-(void)touchUpSliderAtIndex:(NSInteger)index;



@end

@interface SliderView : UIView

-(void)buildSliderView;

-(void)startSlidView;

-(void)stopSliderView;

@property (nonatomic,strong) id<sliderViewDelegat>sliderViewDataSource;

@end
