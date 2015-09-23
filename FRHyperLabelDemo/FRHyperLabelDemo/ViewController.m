//
//  ViewController.m
//  FRHyperLabelDemo
//
//  Created by Jinghan Wang on 23/9/15.
//  Copyright © 2015 JW. All rights reserved.
//

#import "ViewController.h"
#import "FRHyperLabel.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet FRHyperLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	FRHyperLabel *label = self.label;
	label.numberOfLines = 0;
	
	NSString *string = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque quis blandit eros, sit amet vehicula justo. Nam at urna neque. Maecenas ac sem eu sem porta dictum nec vel tellus.";
	NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]};
	
	label.attributedText = [[NSAttributedString alloc]initWithString:string attributes:attributes];
	
	void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring){
		NSLog(@"Selected: %@", substring);
	};
	
	[label setLinksForSubstrings:@[@"Lorem", @"Pellentesque", @"blandit", @"Maecenas"] withLinkHandler:handler];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
