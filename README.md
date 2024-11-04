## QUESTIONS:

## What issues prevent us from using storyboards in real projects?
There is a plenty of difficulties with working with storyboards in real projects: 
Merge conflicts can occur when multiple developers are working on the same file, because storyboards are XML files; 
It is also more difficult to create custom UI elements in storyboards than using programming creation; 
View controllers load longer when you use storyboards; 
It is hard to reuse some components from a storyboard in other projects, you can even create your own snippets if you make your components programmatically.

## What does the code on lines 25 and 29 do?
```
25. title.translatesAutoresizingMaskIntoConstraints = false
29. view.addSubview(title)
```
Line 25 keeps UIKit from creating automatic constraints for this view. UIKit always implicitly creates constraints based on the autoresizing mask.
Line 29 adds the title to the main view hierarchy and makes it visible.


## What is a safe area layout guide?
It is a property of UIVIew that defines the part of the screen without inaccessible areas, such as the status bar, the home indicator and the notch. 
It helps developers build layouts that adapt to different screen sizes.

## What is [weak self] on line 23 and why it is important?
```
23. sliderRed.valueChanged = { [weak self] value in
24. self?.view.backgroundColor = ...
25. }
```
[weak self] creates a weak reference to self. Weak reference prevents retain cycles and memory leaks, 
because objects can be deallocated when they are no longer needed.

## What does clipsToBounds mean?
The clipsToBounds property of a UIView determines whether subviews that extend beyond the bounds of the view should be clipped (not visible). 

## What is the valueChanged type? What is Void and what is Double?
The valueChanged is a UIControl event, it is triggered when the user interacts with the control and changes its value. Void represents empty return type.
Double is a type that represents a 64-bit floating-point number.
