//
//  JSShuffingPictureCollectionViewCell.h
//  JSShufflingPictureDemo
//
//  Created by jhon.sun on 15/11/17.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//
#define shuffingPictureCollectionViewCellIdentifier @"shuffingPictureCollectionViewCellIdentifier"

#import <UIKit/UIKit.h>

@interface JSShuffingPictureCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imageUrlString;
@property (nonatomic, assign) id imageObject;

@end
