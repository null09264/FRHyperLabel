# FRHyperLabel

FRHyperLabel is a subclass of UILabel, which powers you the capablilty to add one or more hyperlinks to your label texts. With FRHyperLabel, You can define different style, handler and highlight appearance for difference hyperlinks in a super-easy way.

#### Usage
The code to define a bunch of hyperlinks can be as short as one statement, just use the API: `setLinkForRange:withLinkHandler`, which takes in an substring range and a tap handler as input and setup the links with an element touch feedback.

##### Example:
```objc
//Step 1: Define a normal attributed string for non-link texts
NSString *string = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque quis blandit eros, sit amet vehicula justo. Nam at urna neque. Maecenas ac sem eu sem porta dictum nec vel tellus.";
NSDictionary *attributes = @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]};

label.attributedText = [[NSAttributedString alloc]initWithString:string attributes:attributes];


//Step 2: Define a selection handler block
void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring){
	NSLog(@"Selected: %@", substring);
};


//Step 3: Add link substrings
[label setLinksForSubstrings:@[@"Lorem", @"Pellentesque", @"blandit", @"Maecenas"] withLinkHandler:handler];
```
