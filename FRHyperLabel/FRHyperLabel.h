//
//  FRHyperLabel.h
//  FRHyperLabelDemo
//
//  Created by Jinghan Wang on 23/9/15.
//  Copyright © 2015 JW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRHyperLabel : UILabel

@property (nonatomic) NSDictionary *defaultLinkAttribute;
@property (nonatomic) NSDictionary *highlightLinkAttribute;

- (void)setLinkForRange:(NSRange)range withLinkHandler:(void(^)(void))handler;
- (void)setLinkForRange:(NSRange)range withAttributes:(NSDictionary *)attributes andLinkHandler:(void (^)(void))handler;

@end
