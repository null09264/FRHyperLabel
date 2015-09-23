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
	
	//Step 1: Define a normal attributed string for non-link texts
	NSString *string = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque quis blandit eros, sit amet vehicula justo. Nam at urna neque. Maecenas ac sem eu sem porta dictum nec vel tellus.";
	NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]};
	label.attributedText = [[NSAttributedString alloc]initWithString:string attributes:attributes];
	
	//Step 2: Define a selection handler block
	void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring){
		UIAlertController *controller = [UIAlertController alertControllerWithTitle:substring message:nil preferredStyle:UIAlertControllerStyleAlert];
		[controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
		[self presentViewController:controller animated:YES completion:nil];
	};

	//Step 3: Add link substrings
	[label setLinksForSubstrings:@[@"Lorem", @"Pellentesque", @"blandit", @"Maecenas"] withLinkHandler:handler];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
