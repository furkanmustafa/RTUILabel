//
//  RTLabelWrapper.m
//
//  Created by Furkan Mustafa on 01/12/13.
//  https://github.com/furkanmustafa/RTUILabel
//	also see https://github.com/honcheng/RTLabel
//
//	Makes you able to use RTLabel in xib files
//	also centers text vertically by default (like UILabel)
//

#import "RTUILabel.h"

@implementation RTUILabel

- (void)dealloc {
	self.textFilter = nil;
	self.rtLabel = nil;
	[super dealloc];
}
- (void)setup {
	self.rtLabel = [[[RTLabel alloc] initWithFrame:self.bounds] autorelease];
	[self addSubview:_rtLabel];
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		// clear annoying default UILabel background
		super.backgroundColor = UIColor.clearColor;
		[self setup];
    }
    return self;
}
- (id)initWithCoder:(NSCoder*)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setup];
		// move parameter values from UILabel to RTLabel
		self.verticalCenteringEnabled = YES;
		self.textColor = super.textColor;
		self.textAlignment = super.textAlignment;
		self.font = super.font;
		self.backgroundColor = super.backgroundColor;
		self.text = super.text; [super setText:nil];
	}
	return self;
}

#pragma mark Proxy Properties

- (void)setTextColor:(UIColor*)textColor {
	[_rtLabel setTextColor:textColor];
}
- (UIColor*)textColor { return _rtLabel.textColor; }
- (void)setText:(NSString *)text {
	if (self.textFilter) {
		text = self.textFilter(text);
	}
	[_rtLabel setText:text];
	[self setNeedsLayout];
}
- (NSString*)text { return _rtLabel.text; }
- (void)setFont:(UIFont*)font {
	[_rtLabel setFont:font];
	[self setNeedsLayout];
}
- (UIFont*)font { return _rtLabel.font; }
- (void)setTextAlignment:(NSTextAlignment)textAlignment {
	if (textAlignment == NSTextAlignmentCenter) _rtLabel.textAlignment = RTTextAlignmentCenter;
	else if (textAlignment == NSTextAlignmentLeft) _rtLabel.textAlignment = RTTextAlignmentLeft;
	else if (textAlignment == NSTextAlignmentRight) _rtLabel.textAlignment = RTTextAlignmentRight;
	else if (textAlignment == NSTextAlignmentJustified) _rtLabel.textAlignment = RTTextAlignmentJustify;
	[self setNeedsLayout];
}
- (NSTextAlignment)textAlignment {
	RTTextAlignment textAlignment = _rtLabel.textAlignment;
	if (textAlignment == RTTextAlignmentCenter) return NSTextAlignmentCenter;
	if (textAlignment == RTTextAlignmentLeft) return NSTextAlignmentLeft;
	if (textAlignment == RTTextAlignmentRight) return NSTextAlignmentRight;
	if (textAlignment == RTTextAlignmentJustify) return NSTextAlignmentJustified;
	return 0;
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
	if (lineBreakMode == NSLineBreakByWordWrapping) _rtLabel.lineBreakMode = RTTextLineBreakModeWordWrapping;
	else if (lineBreakMode == NSLineBreakByCharWrapping) _rtLabel.lineBreakMode = RTTextLineBreakModeCharWrapping;
	else if (lineBreakMode == NSLineBreakByClipping) _rtLabel.lineBreakMode = RTTextLineBreakModeClip;
	[self setNeedsLayout];
}
- (NSLineBreakMode)lineBreakMode {
	RTTextLineBreakMode lineBreakMode = _rtLabel.lineBreakMode;
	if (lineBreakMode == RTTextLineBreakModeWordWrapping) return NSLineBreakByWordWrapping;
	if (lineBreakMode == RTTextLineBreakModeCharWrapping) return NSLineBreakByCharWrapping;
	if (lineBreakMode == RTTextLineBreakModeClip) return NSLineBreakByClipping;
	return 0;
}

#pragma mark TextFilter Block

- (void)setTextFilter:(RTUILabelTextFilter)textFilter {
	[_textFilter autorelease];
	_textFilter = [textFilter copy];
	if (_textFilter) {
		self.text = self.text; // reset
	}
}

#pragma mark Layout

- (void)layoutSubviews {
	[super layoutSubviews];
	if (_verticalCenteringEnabled) {
		CGSize optimumSize = _rtLabel.optimumSize;
		_rtLabel.frame = ({
			CGRect newFrame = self.bounds;
			newFrame.origin.y += floorf((newFrame.size.height - optimumSize.height) / 2);
			newFrame.size.height = optimumSize.height;
			newFrame;
		});
	} else {
		_rtLabel.frame = self.bounds;
	}
}

@end
