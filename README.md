RTUILabel
=========

RTLabel Wrapper to use with Interface Builder.

you know how to use it. it's simple. set class to `RTUILabel` in xib and header file. doesn't use arc.

you might want to check `textFilter` property, it's cool, sample;

```objc
myLabel.textFilter = ^(NSString* text) {
	text = text.localizedStringWithDefaultPattern;
	text = [text replaceRegex:@"\\*([^\\*]+)\\*" intoTemplate:@"<b>$1</b>"];
	return text;
};
```
if you're interested in the cool functions used above, see: https://gist.github.com/furkanmustafa/7723375, so you basicly get localization in interface builder too. Formatting is shown below;
```objc
// [NSBundle.mainBundle localizedStringForKey:@"Name" value:@"" table:nil]
myLabel.text = @"@lo{Name}";
// [NSString stringWithFormat:[NSBundle.mainBundle localizedStringForKey:@"Name" value:@"" table:nil], @"Haruhi Suzumiya", @"25"]
myLabel.text = @"@lo{Greet(Haruhi Suzumiya,25)}";
```

also

```objc
// use rtlabel properties
myLabel.rtLabel.lineSpacing = 7.0;
```

