# NYAlertViewController

NYAlertViewController is a replacement for UIAlertController/UIAlertView with support for content views and UI customization.

![Example](https://github.com/nealyoung/NYAlertViewController/raw/master/header.png)

### Features
* Includes content view property for adding custom views to the alert view
* Block-based API similar to UIAlertController/UIAlertAction
* Support for all screen orientations and iPad screen sizes
* Easily add text fields with simple API identical to UIAlertController
* Choose between fade (similar to UIAlertController) or slide transition animations

### Installation
#### Manual
Add the files to your project manually by dragging the NYAlertViewController directory into your Xcode project.

#### CocoaPods
Add `pod 'NYAlertViewController'` to your Podfile, and run `pod install`.

### Usage Examples
An Objectve-C example project demonstrating customization options is included in the NYAlertViewControllerDemo directory.

#### Objective-C

```objc
// Import the class and create an NYAlertViewController instance
#import "NYAlertViewController.h"

// ...

NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];

// Set a title and message
alertViewController.title = NSLocalizedString(@"Custom UI", nil);
alertViewController.message = NSLocalizedString(@"Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus.", nil);

// Customize appearance as desired
alertViewController.buttonCornerRadius = 20.0f;
alertViewController.view.tintColor = self.view.tintColor;

alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:19.0f];
alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Medium" size:16.0f];
alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.buttonTitleFont.pointSize];
alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];

alertViewController.swipeDismissalGestureEnabled = YES:
alertViewController.backgroundTapDismissalGestureEnabled = YES:

// Add alert actions
[alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Done", nil)
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(NYAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];

// Present the alert view controller
[self presentViewController:alertViewController animated:YES];
```

#### Swift

```swift
import NYAlertViewController

// ...

let alertViewController = NYAlertViewController()

// Set a title and message
alertViewController.title = "Custom UI"
alertViewController.message = "Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus."

// Customize appearance as desired
alertViewController.buttonCornerRadius = 20.0
alertViewController.view.tintColor = self.view.tintColor

alertViewController.titleFont = UIFont(name: "AvenirNext-Bold", size: 19.0)
alertViewController.messageFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
alertViewController.cancelButtonTitleFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
alertViewController.cancelButtonTitleFont = UIFont(name: "AvenirNext-Medium", size: 16.0)

alertViewController.swipeDismissalGestureEnabled = true
alertViewController.backgroundTapDismissalGestureEnabled = true

// Add alert actions
let cancelAction = NYAlertAction(
    title: "Done",
    style: .Cancel,
    handler: { (action: NYAlertAction!) -> Void in
        self.dismissViewControllerAnimated(true, completion: nil)
    }
)
alertViewController.addAction(cancelAction)

// Present the alert view controller
self.presentViewController(alertViewController, animated: true, completion: nil)
```

### To-Dos
* Add different transition options (fade in, slide from top, etc.)

### License
This project is released under the MIT License.
