//
//  LGBaseUIService.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/5.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGBaseUIService.h"

@implementation LGBaseUIService

#pragma mark - UITableViewDataSource


/****************** begin footer view 表尾部视图 ******************/

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    static NSString *footerViewId = @"baseFooterViewId";
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewId];
    if (nil == footerView) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerViewId];
        [footerView.contentView setBackgroundColor:[FMColor fmColor_Controller_View_Background]];
    }
    return  footerView;
}
/****************** end footer view 表尾部视图 ******************/


/****************** begin header view 表头部视图 ******************/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *footerViewId = @"baseFooterViewId";
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewId];
    if (nil == footerView) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerViewId];
        [footerView.contentView setBackgroundColor:[FMColor fmColor_Controller_View_Background]];
    }
    return  footerView;
}

/****************** end header view 表尾部视图 ******************/

@end
