//
//  CYCollectionViewLayout.h
//  CollectionViewStudy2
//
//  Created by Yang Chao on 7/1/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYCollectionViewLayout;

@protocol CYMasonryViewLayoutDelegate <NSObject>
@required
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(CYCollectionViewLayout *)layout
  heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CYCollectionViewLayout : UICollectionViewLayout

@property (assign, nonatomic) CGFloat interItemSpacing;
@property (assign, nonatomic) NSUInteger numberOfCols;

@end
