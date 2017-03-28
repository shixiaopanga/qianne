//
//  SlumpCollectionViewFlowLayout.m
//  new
//
//  Created by lzd on 2017/3/26.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "SlumpCollectionViewFlowLayout.h"
#import "SlumpCollectionViewCell.h"

@implementation SlumpCollectionViewFlowLayout

- (instancetype)init:(CGSize)slimpItemSize {
    self = [super init];
    if (self) {
        self.itemSize = slimpItemSize;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 5;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *AttributesArray = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    CGFloat centerX = self.collectionView.contentOffset.x + UI_SCREEN_WIDTH * 0.5;
    
    for (UICollectionViewLayoutAttributes *attribute in AttributesArray) {
        if ((self.collectionView.contentOffset.x < 0) || (self.collectionView.contentOffset.x > self.collectionView.contentSize.width - UI_SCREEN_WIDTH)){
            //边界值不需要交错效果
            continue;
        }
        CGFloat distanceFromCenterScale = (attribute.center.x - centerX)/(2*UI_SCREEN_WIDTH + 10);
        if (distanceFromCenterScale < -0.5) {
            distanceFromCenterScale = -0.5;
        }else if (distanceFromCenterScale > 0.5) {
            distanceFromCenterScale = 0.5;
        }
        
        SlumpCollectionViewCell *cell = (SlumpCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:attribute.indexPath];
        CGPoint newCenter = CGPointMake((0.5-distanceFromCenterScale)*UI_SCREEN_WIDTH, cell.frame.size.height/2);
        
        cell.showView.center = newCenter;
    }
    return AttributesArray;
}
@end
