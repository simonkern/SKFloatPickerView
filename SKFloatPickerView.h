//
//  SKFloatPickerView.h
//  FloatPickerview
//
//  Created by Simon Kern on 27.09.12.
//  Copyright (c) 2012 Simon Kern. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKFloatPickerViewDelegate;
@interface SKFloatPickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak) id <NSObject, SKFloatPickerViewDelegate> pickerViewDelegate;

- (id)initWithInts:(int)aNumberOfIntegers andDecimals:(int)aNumberOfDecimals
andNegativeNumbers:(BOOL)negativeNumbersAllowed;
-(void) setStartValue:(float)value;

@end

@protocol SKFloatPickerViewDelegate
@optional
/* This method should handle the new float */
- (void)pickerViewChangedValueTo:(float)newFloat;
- (void)pickerViewActionCancled;

@end