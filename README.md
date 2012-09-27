SKFloatPickerView
=================
by Simon 'Simme' Kern (<a href="http://www.twitter.com/0xsimme">@simme</a>) -  <a href="http://www.simme.org">www.simme.org</a>

A subclass of UIPickerView that can be used for float input.


Usage
=================
Add the  and header <pre>SKFloatPickerView.h</pre> and implementation <pre>SKFlotPickerView.m</pre> files to your project.
Add the <pre><SKFloatPickerViewDelegate></pre> Protocol to your ViewController or wherever you want to handle the user-input.
	
Init SKFloatPickerView with the following command:
<code>- (id)initWithInts:(int)aNumberOfIntegers andDecimals:(int)aNumberOfDecimals
andNegativeNumbers:(BOOL)negativeNumbersAllowed</code>

set the pickerViews property <pre><pickerViewDelegate></pre> to wherever you implemented the <pre><SKFloatPickerViewDelegate></pre> protocol.

Add SKFloatPickerView to your view as a subview or present it in UIActionSheet.

Example initialization and delegate methods
=================
Initialization:
<code>
	SKFloatPickerView *pickerView = [[SKFloatPickerView alloc]initWithInts:2 andDecimals:2 andNegativeNumbers:YES];
	pickerView.pickerViewDelegate = self;
</code>
Delegate method:
<code>
	- (void)pickerViewChangedValueTo:(float)newFloat
	{
	    self.floatLabel.text = [NSString stringWithFormat:@"%2.2f",newFloat];
	}
</code>

License
=================
See LICENSE file. TL;DR: BSD License