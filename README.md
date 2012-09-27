SKFloatPickerView
=================
by Simon 'Simme' Kern (<a href="http://www.twitter.com/0xsimme">@simme</a>) -  <a href="http://www.simme.org">www.simme.org</a>

A subclass of UIPickerView that can be used for float input.


Usage
=================
Add the  and header <code>SKFloatPickerView.h</code> and implementation <pre>SKFlotPickerView.m</pre> files to your project.
Add the <code> SKFloatPickerViewDelegate</code> Protocol to your ViewController or wherever you want to handle the user-input.
	
Init SKFloatPickerView with the following command:
<pre>- (id)initWithInts:(int)aNumberOfIntegers andDecimals:(int)aNumberOfDecimals
		andNegativeNumbers:(BOOL)negativeNumbersAllowed</pre>

set the pickerViews property  <code> pickerViewDelegate </code> to wherever you implemented the <code><SKFloatPickerViewDelegate></code> protocol.

Add SKFloatPickerView to your view as a subview or present it in UIActionSheet.

Example initialization and delegate methods
=================
Initialization:
<pre>
	SKFloatPickerView *pickerView = [[SKFloatPickerView alloc]initWithInts:2 andDecimals:2 andNegativeNumbers:YES];
	pickerView.pickerViewDelegate = self;
</pre>
Delegate method:
<pre>
	- (void)pickerViewChangedValueTo:(float)newFloat
	{
	    self.floatLabel.text = [NSString stringWithFormat:@"%2.2f",newFloat];
	}
</pre>

License
=================
See LICENSE file. TL;DR: BSD License