//
//  ContentScrollViewLayout.m
//  BSBDJ
//
//  Created by Yahaong on 16/6/6.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "ContentScrollViewLayout.h"

@implementation ContentScrollViewLayout


- (void)prepareLayout
{
    [super prepareLayout];
    self.minimumLineSpacing = 0.f;
    self.minimumInteritemSpacing = 0.f;
    if (self.collectionView.bounds.size.height) {
        self.itemSize = self.collectionView.bounds.size;
    }
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
@end
