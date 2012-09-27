//
//  SKViewController.m
//  FloatPickerview
//
//  Created by Simon Kern on 27.09.12.
//  Copyright (c) 2012 Simon Kern. All rights reserved.
//

#import "SKViewController.h"

@interface SKViewController ()

@end

@implementation SKViewController
@synthesize pickerView, floatLabel;
-(SKFloatPickerView *)pickerView
{
    if (!pickerView) {
        pickerView = [[SKFloatPickerView alloc]initWithInts:2 andDecimals:2 andNegativeNumbers:YES];
        pickerView.pickerViewDelegate = self;
    }
    return pickerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (![pickerView superview]) {

        [self.view addSubview:self.pickerView];
        CGRect newFrame = CGRectOffset(pickerView.frame, 0, self.view.frame.size.height-pickerView.frame.size.height);
        [pickerView setFrame:newFrame];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pickerViewChangedValueTo:(float)newFloat
{
    self.floatLabel.text = [NSString stringWithFormat:@"%2.2f",newFloat];
}
@end
