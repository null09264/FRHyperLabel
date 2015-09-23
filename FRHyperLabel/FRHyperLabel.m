//
//  FRHyperLabel.m
//  FRHyperLabelDemo
//
//  Created by Jinghan Wang on 23/9/15.
//  Copyright © 2015 JW. All rights reserved.
//

#import "FRHyperLabel.h"

@interface FRHyperLabel ()

@property (nonatomic) NSMutableDictionary *handlerDictionary;
@property (nonatomic) NSLayoutManager *layoutManager;
@property (nonatomic) NSTextContainer *textContainer;
@property (nonatomic) NSAttributedString *backupAttributedText;

@end

@implementation FRHyperLabel

static CGFloat highLightAnimationTime = 0.15;

- (instancetype)init {
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setup];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self setup];
	}
	return self;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
	[super setAttributedText:attributedText];
}

- (void)setup {
	self.defaultLinkAttribute = @{NSForegroundColorAttributeName: [UIColor colorWithRed:78/255.0 green:107/255.0 blue:166/255.0 alpha:1],
								  NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
	self.highlightLinkAttribute = @{NSForegroundColorAttributeName: [UIColor colorWithRed:242/255.0 green:183/255.0 blue:73/255.0 alpha:1],
									NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
	self.handlerDictionary = [NSMutableDictionary new];
	self.userInteractionEnabled = YES;
}

- (void)setLinkForRange:(NSRange)range withAttributes:(NSDictionary *)attributes andLinkHandler:(void (^)(void))handler {
	NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
	[mutableAttributedString addAttributes:attributes range:range];
	[self.handlerDictionary setObject:handler forKey:[NSValue valueWithRange:range]];
	self.attributedText = mutableAttributedString;
}

- (void)setLinkForRange:(NSRange)range withLinkHandler:(void(^)(void))handler {
	[self setLinkForRange:range withAttributes:self.defaultLinkAttribute andLinkHandler:handler];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	self.backupAttributedText = self.attributedText;
	for (UITouch *touch in touches) {
		CGPoint touchPoint = [touch locationInView:self];
		NSValue *rangeValue = [self attributedTextRangeForPoint:touchPoint];
		if (rangeValue) {
			NSRange range = [rangeValue rangeValue];
			NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
			[attributedString addAttributes:self.highlightLinkAttribute range:range];
			
			[UIView transitionWithView:self duration:highLightAnimationTime options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
				self.attributedText = attributedString;
			} completion:nil];
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[UIView transitionWithView:self duration:highLightAnimationTime options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
		self.attributedText = self.backupAttributedText;
	} completion:nil];
	
	for (UITouch *touch in touches) {
		NSValue *rangeValue = [self attributedTextRangeForPoint:[touch locationInView:self]];
		if (rangeValue) {
			void(^handler)(void) = self.handlerDictionary[rangeValue];
			handler();
		}
	}
}

- (NSValue *)attributedTextRangeForPoint:(CGPoint)point {
	NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
	NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
	
	textContainer.lineFragmentPadding = 0.0;
	textContainer.lineBreakMode = self.lineBreakMode;
	textContainer.maximumNumberOfLines = self.numberOfLines;
	textContainer.size = self.bounds.size;
	[layoutManager addTextContainer:textContainer];
	
	//textStorage to calculate the position
	NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
	[textStorage addLayoutManager:layoutManager];
	
	// find the tapped character location and compare it to the specified range
	CGPoint locationOfTouchInLabel = point;
	CGRect textBoundingBox = [layoutManager usedRectForTextContainer:textContainer];
	CGPoint textContainerOffset = CGPointMake((CGRectGetWidth(self.bounds) - CGRectGetWidth(textBoundingBox)) * 0.5 - CGRectGetMinX(textBoundingBox),
											  (CGRectGetHeight(self.bounds) - CGRectGetHeight(textBoundingBox)) * 0.5 - CGRectGetMinY(textBoundingBox));
	CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x, locationOfTouchInLabel.y - textContainerOffset.y);
	NSInteger indexOfCharacter = [layoutManager characterIndexForPoint:locationOfTouchInTextContainer inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:nil];
	
	for (NSValue *rangeValue in self.handlerDictionary) {
		NSRange range = [rangeValue rangeValue];
		if (NSLocationInRange(indexOfCharacter, range)) {
			return rangeValue;
		}
	}
	
	return nil;
}


@end
