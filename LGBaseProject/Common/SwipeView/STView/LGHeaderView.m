//
//  LGHeaderView.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/25.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGHeaderView.h"
#import "LGBookStoreListCell.h"
//#import "SDCycleScrollView.h"

/// 屏幕宽度
#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
/// 屏幕高度
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
/// 系统 scale
#define SCREEN_SCALE ([[UIScreen mainScreen] scale])

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]


@interface LGHeaderView()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIView *distantView;
@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;


@end


@implementation LGHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self constructContentView];
    }
    return self;
}


- (void)constructContentView {
    
    [self addCyCleView];
    [self addCollectionView];
}

- (void)addCyCleView {
    
}


- (void)addCollectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 15 , 0, 15);
        layout.itemSize = CGSizeMake(90, 200);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 140) collectionViewLayout:layout];
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = HEXCOLOR(0xffffff);
        //注册item类型 这里使用系统的类型
        [_collectionView registerClass:NSClassFromString(@"LGBookStoreListCell") forCellWithReuseIdentifier:@"BookStoreCellID"];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LGBookStoreListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookStoreCellID" forIndexPath:indexPath];
    //    GoodsModel *model = self.dataAry[indexPath.item];
    //    cell.goodsModel = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.didGoodsDetailsAction) {
        //        GoodsModel *model = self.dataAry[indexPath.item];
        //        self.didGoodsDetailsAction(model);
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
