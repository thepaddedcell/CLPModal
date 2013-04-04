CLPModal
========

```CLPModal``` is a custom modal view base class with 2 example implementations - a custom alert view & a picker view. It supports being shown and dismissed from any lateral direction - Top, Bottom, Left or Right.

## Installation
Clone the repository (or add it as a submodule) and then add the files to your project.  
At a minimum, you need to add ```CLPModalView.h```, ```CLPModalView.m``` and ```CLPModal_Private.h```.

## Implementation
```CLPModal``` works by adding a view directly to the application's ```UIWindow```, meaning it will work if you're calling it from a controller that has been presented modally via ```[presentModalViewController:animated:]```.

A ```CLPModal``` contains 2 views as properties - ```animationView``` & ```contentView```.

The ```animationView``` is the root level view to allow for view transition containment, giving you the option to use calls like ```[transitionFromView:toView:duration:options:completion:]```.

The ```contentView``` is where the main content of the modal view should be added (note: I chose not to override ```[addSubview:]``` in order to allow for more flexibility down the line, at the expense of some complexity).

## Usage
```CLPModal``` is a base class that shouldn't be instantiated (because it'll be the most boring modal view ever!).
You should subclass it and implement your own content, adding subviews to the ```contentView```, or if you're feeling adventurous, you can replace the entire view.

So simply add your subviews inside ```-(void)loadView``` and then present the modal as follows:

	YourCustomModal* modal = [[YourCustomModal alloc] init];
	[modal show];

or

	[[[YourCustomModal alloc] init] show];

Obviously, you'll probably end up with more complex initialisers (see ```CLPAlertView``` or ```CLPPickerView``` for examples).

## Questions
Direct any questions you have to me via Issues or on Twitter [at] thepaddedcell.
  
## Happy coding!

