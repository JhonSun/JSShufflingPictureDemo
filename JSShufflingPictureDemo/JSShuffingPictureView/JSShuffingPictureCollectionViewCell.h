//
//  JSShuffingPictureCollectionViewCell.h
//  JSShufflingPictureDemo
//
//  Created by jhon.sun on 15/11/17.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *shuffingPictureCollectionViewCellIdentifier = @"shuffingPictureCollectionViewCellIdentifier";

@interface JSShuffingPictureCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imageUrlString;
@property (nonatomic, assign) id imageObject;
@property (nonatomic, strong) UIImage *defaultImage;

@end
