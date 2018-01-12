//
//  FMRURLProtocol.m
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import "FMRURLProtocol.h"
#import "FMRApplication.h"

@interface FMRURLProtocol ()

@end

@implementation FMRURLProtocol

+ (void)load {
    [NSURLProtocol registerClass:[FMRURLProtocol class]];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return [[FMRApplication sharedInstance] canOpenURL:request.URL];
}

+ (BOOL)canInitWithTask:(NSURLSessionTask *)task {
    return [[FMRApplication sharedInstance] canOpenURL:task.originalRequest.URL];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id responseObject = [[FMRApplication sharedInstance] openURL:self.request.URL];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([responseObject isKindOfClass:[NSString class]]) {
                NSData *data = [(NSString *)responseObject dataUsingEncoding:NSUTF8StringEncoding];
                [[self client] URLProtocol:self
                        didReceiveResponse:[self FMRResponse:@"text/plain" contentLength:data.length]
                        cacheStoragePolicy:NSURLCacheStorageNotAllowed];
                [[self client] URLProtocol:self
                               didLoadData:data];
                [[self client] URLProtocolDidFinishLoading:self];
            }
            else if ([responseObject isKindOfClass:[NSData class]]) {
                [[self client] URLProtocol:self
                        didReceiveResponse:[self FMRResponse:@"application/octet-stream" contentLength:[responseObject length]]
                        cacheStoragePolicy:NSURLCacheStorageNotAllowed];
                [[self client] URLProtocol:self
                               didLoadData:responseObject];
                [[self client] URLProtocolDidFinishLoading:self];
            }
            else {
                [[self client] URLProtocol:self didFailWithError:[NSError errorWithDomain:@"FMRouter"
                                                                                     code:500
                                                                                 userInfo:@{}]];
            }
        });
    });
}

- (void)stopLoading {
    return;
}

- (NSURLResponse *)FMRResponse:(NSString *)MIMEType contentLength:(NSInteger)contentLength {
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:MIMEType expectedContentLength:contentLength textEncodingName:nil];
    return response;
}

@end
