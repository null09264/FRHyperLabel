# FRHyperLabel

FRHyperLabel is a subclass of UILabel, which powers you the capablilty to add one or more hyperlinks to your label texts. With FRHyperLabel, You can define different style, handler and highlight appearance for difference hyperlinks in a super-easy way.

####Usage
The code to define an hyperlink can be as short as one line, just use the API: `setLinkForRange:withLinkHandler`, which takes in an substring range and a tap handler as input and setup the links with an element touch feedback.

#####Ex.
```objc

[label setLinkForRange:NSMakeRange(0, 4) withLinkHandler:^{
	NSLog(@"First 4 character is selected");
}];

```
