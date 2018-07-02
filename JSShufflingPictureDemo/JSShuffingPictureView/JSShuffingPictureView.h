//
//  JSShuffingPictureCollectionView.h
//  JSShufflingPictureDemo
//
//  Created by jhon.sun on 15/11/17.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSShuffingPictureView : UIView

@property (nonatomic, assign) BOOL isZoom;// 是否可以缩放
@property (nonatomic, assign) BOOL isLoop;//是否循环滚动,默认YES，设置为NO是不要设置自动滚动
@property (nonatomic, strong) NSArray *imageArray;// 设置图片数组最后在设置
@property (nonatomic, assign) NSTimeInterval autoScrollTime;//自动滚动间隔时间，不设置就不自动滚动
@property (nonatomic, strong) UIColor *pageControlCurrentColor;
@property (nonatomic, strong) UIColor *pageControlThumColor;
@property (nonatomic, strong) UIImage *defaultImage;//默认图片，不设置图片数组或者网络图片获取失败时使用

@property (nonatomic, copy) void (^selectItemEvent)(NSInteger selectIndex);

@end
