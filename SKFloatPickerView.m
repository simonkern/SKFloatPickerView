//
//  SKFloatPickerView.m
//  FloatPickerview
//
//  Created by Simon Kern on 27.09.12.
//  Copyright (c) 2012 Simon Kern. All rights reserved.
//

#import "SKFloatPickerView.h"


// Identifiers and widths for the various components
#define LABEL_TAG 43
#define COMPONENT_VIEW_BACKGROUND [UIColor clearColor]
#define COMPONENT_ROW_HEIGHT 50

@interface SKFloatPickerView ()
@property (nonatomic) float newFloat;
/* used to calculate the new value */
@property (readonly) int numberOfIntegers;
@property (readonly) int numberOfDecimals;
@property (readonly) BOOL negativeNumbers;
/* determines whether negative numbers are allowed or not */
@end

@implementation SKFloatPickerView {
    CGFloat cachedComponenWidth;
}
@synthesize numberOfIntegers, numberOfDecimals, negativeNumbers, newFloat;

#pragma mark - designated initializer
-(id)initWithInts:(int)aNumberOfIntegers andDecimals:(int)aNumberOfDecimals
andNegativeNumbers:(BOOL)negativeNumbersAllowed
{
    if (self = [super init]) {
        numberOfIntegers = aNumberOfIntegers;
        numberOfDecimals = aNumberOfDecimals;
        negativeNumbers = negativeNumbersAllowed;
        self.showsSelectionIndicator = YES;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - UIPickerView DataSource
-(int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (negativeNumbers) {
        return self.numberOfIntegers+self.numberOfDecimals+1;
    }
    return self.numberOfIntegers+self.numberOfDecimals;
}

-(int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.negativeNumbers && component == 0) {
        return 2;
    }
    return 10;
}


- (UILabel *)viewForComponent:(NSInteger)component {

	/* Simply creates a label to contain the text.	 */
    int componentViewWidth = [self pickerView:self widthForComponent:component];
	CGRect frame = CGRectMake(0.0, 0.0, componentViewWidth, 32.0);
	UILabel *aLabel = [[UILabel alloc] initWithFrame:frame];
	aLabel.textAlignment = NSTextAlignmentCenter;
	aLabel.backgroundColor = COMPONENT_VIEW_BACKGROUND;
	aLabel.font = [UIFont systemFontOfSize:24.0];
	aLabel.userInteractionEnabled = NO;
	aLabel.tag = LABEL_TAG;
	return aLabel;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{

    UIView *returnView = nil;
    // Reuse the label if possible, otherwise create and configure a new one.
    if (view.tag == LABEL_TAG) {
        returnView = view;
    }
    else {
        returnView = [self viewForComponent:component];
    }

    UILabel *theLabel = (UILabel *)returnView;

    theLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return returnView;
}
- (CGFloat)widthForComponen:(NSInteger)component
{
    CGFloat width = self.frame.size.width;
    width -= width/10;
    if (self.negativeNumbers) {
        width /= self.numberOfIntegers+self.numberOfDecimals+1;
    }
    else {
        width /= self.numberOfIntegers+self.numberOfDecimals;
    }
    return width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return [self widthForComponen:component];
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.negativeNumbers)
    {
        if (component == 0) {
            if (row == 0) {
                return @"+";
            }
            else {
                return @"-";
            }
        }
        //this is the last int in this case, therefore it includes the sperator
        else if (component == self.numberOfIntegers) {
            return [NSString stringWithFormat:@"%d ,", row];
        }
    }
    else if (component == self.numberOfIntegers -1)
    {
        //this is the last int in this case, therefore it includes the sperator
        return [NSString stringWithFormat:@"%d  ,", row];
    }
    //Default case
    return [NSString stringWithFormat:@"%d", row];
}

- (void)setComponentSpecificValueForComponent:(int)i withFloat:(float)aFloat
{
    if (i < self.numberOfComponents) {
        int row;
        float rest;
        if (self.negativeNumbers) {
            row = aFloat/pow(10, self.numberOfIntegers-i);
            rest = fmod(aFloat, pow(10, self.numberOfIntegers-i));
        }
        else {
            row = aFloat/pow(10, self.numberOfIntegers-1-i);
            rest = fmod(aFloat, pow(10, self.numberOfIntegers-1-i));

        }
        [self selectRow:row inComponent:i animated:YES];
        i++;
        [self setComponentSpecificValueForComponent:i withFloat:rest];
    }
}

- (void)setStartValue:(float)value {
    if (self.negativeNumbers) {
        if (value < 0) {
            [self selectRow:1 inComponent:0 animated:YES];
            value *=-1;
        }
        [self setComponentSpecificValueForComponent:1 withFloat:value];
    }
    else {
        [self setComponentSpecificValueForComponent:0 withFloat:value];
    }


}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.newFloat = 0;
    if (negativeNumbers) {
        for (int i=1; i<=self.numberOfComponents-1; i++) {
            self.newFloat += [pickerView selectedRowInComponent:i]*pow(10, self.numberOfIntegers-i);
        }
        if ([pickerView selectedRowInComponent:0]==1) newFloat *=-1;
    }
    else {
        for (int i=0; i<=self.numberOfComponents-1; i++) {
            self.newFloat += [pickerView selectedRowInComponent:i]*pow(10, self.numberOfIntegers-(i+1));
        }
    }

#ifdef DEBUG
    NSLog(@"PickerView changed Value to %.2f",self.newFloat);
#endif

    if ([self.pickerViewDelegate respondsToSelector:@selector(pickerViewChangedValueTo:)]) {
        [self.pickerViewDelegate pickerViewChangedValueTo:self.newFloat];
    }
}



@end
