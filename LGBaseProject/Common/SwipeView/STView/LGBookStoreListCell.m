//
//  LGBookStoreListCell.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/19.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGBookStoreListCell.h"
#import <Masonry/Masonry.h>


//转换十六进制值到rgb
#define FMCOLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** strongSelf和weakSelf*/
#define  FM_WEAKSELF      __weak typeof(self) weakSelf                    = self;
#define  FM_STRONGSELF(weakSelf)    __strong __typeof(weakSelf)strongSelf = weakSelf;


@interface LGBookStoreListCell ()


@end

@implementation LGBookStoreListCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
        [self constructContentView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
}

- (void)initView {
    [self.contentView setBackgroundColor:FMCOLOR_HEX(0xFFFFFF)];
}


- (void)constructContentView {
    [self addUserImageView];
    [self addNameLabel];

}

- (void)addUserImageView {
    if (!_bookImageView) {
        _bookImageView = [[UIImageView alloc] init];
        _bookImageView.layer.masksToBounds = YES;
        _bookImageView.layer.cornerRadius = 20;
        [_bookImageView setImage:[UIImage imageNamed:@"The-book-1"]];
        [self.contentView addSubview:_bookImageView];
        FM_WEAKSELF
        [_bookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.top.mas_equalTo(weakSelf).offset(20);
            make.width.height.mas_offset(40);
        }];
    }
}

- (void)addNameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"测试书店";
        [self.contentView addSubview:_nameLabel];
        FM_WEAKSELF
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.bookImageView);
            make.top.mas_equalTo(weakSelf.bookImageView.mas_bottom).offset(12);
        }];
    }
}


@end
