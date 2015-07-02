//
//  CYCollectionViewLayout.m
//  CollectionViewStudy2
//
//  Created by Yang Chao on 7/1/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "CYCollectionViewLayout.h"

@interface CYCollectionViewLayout ()

@property (strong, nonatomic) NSMutableDictionary *lastYValueForColumn;
@property (strong, nonatomic) NSMutableDictionary *layoutInfo;

@end

@implementation CYCollectionViewLayout

#pragma mark - System Methods

- (void)prepareLayout
{
    self.numberOfCols = 3;
    self.interItemSpacing = 12.5;
    
    self.lastYValueForColumn = [NSMutableDictionary dictionary];
    CGFloat currentColumn = 0;
    CGFloat fullWidth = self.collectionView.frame.size.width;
    CGFloat availableSpaceExcludingPadding = fullWidth - (self.interItemSpacing * (self.numberOfCols + 1));
    CGFloat itemWidth = availableSpaceExcludingPadding / self.numberOfCols;
    self.layoutInfo = [NSMutableDictionary dictionary];
    NSIndexPath *indexpath;
    NSInteger numSections = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < numSections; section++) {
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item < numItems; item++) {
            indexpath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
            
            CGFloat x = self.interItemSpacing + (self.interItemSpacing + itemWidth) * currentColumn;
            CGFloat y = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
            
            CGFloat height = [((id<CYMasonryViewLayoutDelegate>)self.collectionView.delegate)
                              collectionView:self.collectionView
                              layout:self
                              heightForItemAtIndexPath:indexpath];
            
            itemAttributes.frame = CGRectMake(x, y, itemWidth, height);
            y += height;
            y += self.interItemSpacing;
            
            self.lastYValueForColumn[@(currentColumn)] = @(y);
            
            currentColumn++;
            
            if (currentColumn == self.numberOfCols) {
                currentColumn =  0;
            }
            self.layoutInfo[indexpath] = itemAttributes;
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                         UICollectionViewLayoutAttributes *attributes,
                                                         BOOL *stop) {
        
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }];
    return allAttributes;
}

- (CGSize)collectionViewContentSize
{
    NSUInteger currentColumn = 0;
    CGFloat maxHeight = 0;
    do {
        CGFloat height = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
        if(height > maxHeight)
            maxHeight = height;
        currentColumn ++;
    } while (currentColumn < self.numberOfCols);
    
    return CGSizeMake(self.collectionView.frame.size.width, maxHeight);
}

@end
