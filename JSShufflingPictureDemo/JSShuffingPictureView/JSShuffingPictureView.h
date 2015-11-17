//
//  JSShuffingPictureCollectionView.h
//  JSShufflingPictureDemo
//
//  Created by jhon.sun on 15/11/17.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSShuffingPictureView : UIView

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger autoScrollTime;
@property (nonatomic, strong) UIColor *pageControlCurrentColor;
@property (nonatomic, strong) UIColor *pageControlThumColor;

@end
