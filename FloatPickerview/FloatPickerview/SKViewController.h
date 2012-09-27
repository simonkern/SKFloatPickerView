//
//  SKViewController.h
//  FloatPickerview
//
//  Created by Simon Kern on 27.09.12.
//  Copyright (c) 2012 Simon Kern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKFloatPickerView.h"
@interface SKViewController : UIViewController <SKFloatPickerViewDelegate>
@property (strong, readonly) SKFloatPickerView *pickerView;
@property (weak) IBOutlet UILabel *floatLabel;
@end
