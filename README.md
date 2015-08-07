# NYAlertViewController

NYAlertViewController is a replacement for UIAlertController/UIAlertView with support for content views and UI customization.

![Example](https://github.com/nealyoung/NYAlertViewController/raw/master/header.png)

### Features
* Includes content view property for adding custom views to the alert view
* Block-based API similar to UIAlertController/UIAlertAction
* Support for all screen orientations and iPad screen sizes

### Installation
#### Manual
Add the files to your project manually by dragging the NYAlertViewController directory into your Xcode project.

#### CocoaPods
Add `pod 'NYAlertViewController'` to your Podfile, and run `pod install`.

### Usage
An example project is included in the NYAlertViewControllerDemo directory.

```objc
// Import the class and create an NYAlertViewController instance
#import "NYAlertViewController.h"
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

// Add alert actions
[alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Done", nil)
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(NYAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];

// Present the alert view controller
[self presentViewController:alertViewController animated:YES];
```

### To-Dos
* Add different transition options (fade in, slide from top, etc.)

### License
This project is released under the MIT License.
