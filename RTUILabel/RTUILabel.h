//
//  RTLabelWrapper.h
//
//  Created by Furkan Mustafa on 01/12/13.
//  https://github.com/furkanmustafa/RTUILabel
//	also see https://github.com/honcheng/RTLabel
//
//	Makes you able to use RTLabel in xib files
//	also centers text vertically by default (like UILabel)
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

typedef NSString* (^RTUILabelTextFilter)(NSString*);

@interface RTUILabel : UILabel

@property (nonatomic, strong) RTLabel* rtLabel;
@property (nonatomic, readwrite) BOOL verticalCenteringEnabled;
@property (nonatomic, copy) RTUILabelTextFilter textFilter;

@end
