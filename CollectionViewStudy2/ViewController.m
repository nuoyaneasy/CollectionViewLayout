//
//  ViewController.m
//  CollectionViewStudy2
//
//  Created by Yang Chao on 7/1/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "ViewController.h"
#import "CYCollectionViewLayout.h"

@interface ViewController () <CYMasonryViewLayoutDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionView.collectionViewLayout = [[CYCollectionViewLayout alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat randomeHeight = 100 + (arc4random() % 140);
    return CGSizeMake(100, randomeHeight);
}

// this will be called if our layout is MKMasonryViewLayout
- (CGFloat) collectionView:(UICollectionView*) collectionView
                    layout:(CYCollectionViewLayout*) layout
  heightForItemAtIndexPath:(NSIndexPath*) indexPath {
    
    // we will use a random height from 100 - 400
    
    CGFloat randomHeight = 100 + (arc4random() % 140);
    return randomHeight;
}

@end
