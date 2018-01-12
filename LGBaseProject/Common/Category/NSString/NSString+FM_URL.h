//
//  NSString+fm_URL.h
//  fm_ViewKit
//
//  Created by dm on 15/5/23.
//  Copyright (c) 2015年 fm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+FMPublic.h"

@interface NSString (FM_URL)

- (NSString*)fm_URLEncodedString;

- (NSString*)fm_URLDecodedString;

- (NSString*)fm_replaceUnicode;



@end
