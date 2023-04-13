# NYAlertViewController

NYAlertViewController is a replacement for UIAlertController/UIAlertView with support for content views and UI customization.

![Swift-Package](https://img.shields.io/badge/Swift--Package-Compatible-green)
![Cocoa-Pods](https://img.shields.io/badge/CocoaPods-Compatible-green)

![Example](https://github.com/nealyoung/NYAlertViewController/raw/master/header.png)

### Features
* Includes content view property for adding custom views to the alert view
* Block-based API similar to UIAlertController/UIAlertAction
* Support for all screen orientations and iPad screen sizes
* Easily add text fields with simple API identical to UIAlertController
* Choose between fade (similar to UIAlertController) or slide transition animations

## Installation
#### Manual
Add the files to your project manually by dragging the NYAlertViewController directory into your Xcode project.

#### CocoaPods
Add `pod 'NYAlertViewController'` to your Podfile, and run `pod install`.

#### Swift Package Manager
Open your project in Xcode

1. Click "File" -> "Add Packages..."
2. Paste the following URL: https://github.com/gallinaettore/NYAlertViewController

You can specify the dependency in `Package.swift` by adding this:

```swift
.package(url: "https://github.com/gallinaettore/NYAlertViewController.git", .upToNextMajor(from: "2.0.1"))
```


## Usage Example


#### Objective-C
An Objective-C example project demonstrating customization options is included in the NYAlertViewControllerDemo directory.

```objc
// Import the class and create an NYAlertViewController instance
#import "NYAlertViewController.h"

// ...

// Set a title and message
NSString *title = @"Location Permission";
NSString *message = @"Set the alertViewContentView property to add custom views to the alert view";

// Customize appearance as desired
NYAlertViewControllerConfiguration *configuration = [NYAlertViewControllerConfiguration new];
configuration.contentViewInset = UIEdgeInsetsMake(12.0f, 8.0f, 8.0f, 8.0f);
configuration.alertViewBackgroundColor = [UIColor colorWithRed:0.23f green:0.23f blue:0.27f alpha:1.0f];
configuration.separatorColor = [UIColor colorWithRed:0.16f green:0.16f blue:0.2f alpha:1.0f];
configuration.titleTextColor = [UIColor whiteColor];
configuration.messageTextColor = [UIColor whiteColor];

configuration.buttonConfiguration = [NYAlertActionConfiguration new];
configuration.buttonConfiguration.titleColor = [UIColor whiteColor];

configuration.cancelButtonConfiguration.titleColor = [UIColor whiteColor];

// Set up alert actions
NYAlertAction *cancelAction = [[NYAlertAction alloc] initWithTitle:@"Later"
                                                             style:UIAlertActionStyleCancel
                                                           handler:nil];
NYAlertAction *okAction = [[NYAlertAction alloc] initWithTitle:@"Ok"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(NYAlertAction *action) {
                                                           [self doSomething];
                                                       }]];

NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:configuration
                                                                                      title:title
                                                                                    message:message
                                                                                    actions:@[cancelAction, okAction]];

// Optionally add a content view
UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MapIcon"]];
iconImageView.contentMode = UIViewContentModeScaleAspectFit;
[iconImageView.heightAnchor constraintEqualToConstant:60.0f].active = YES;
alertViewController.alertViewContentView = iconImageView;

// Present the alert view controller
[self presentViewController:alertViewController animated:YES completion:nil];
```

#### Swift
An Swift example project demonstrating customization options.

```swift
// Import the class and create an NYAlertViewController instance
import NYAlertViewController

// ...

// Set a title and message
let title = "Location Permission"
let message = "Set the alertViewContentView property to add custom views to the alert view"
    
// Customize appearance as desired
let configuration = NYAlertViewControllerConfiguration()
configuration.contentViewInset = UIEdgeInsets(top: 12, left: 8, bottom: 8, right: 8)
configuration.alertViewBackgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.27, alpha: 1.0)
configuration.separatorColor = UIColor(red: 0.16, green: 0.16, blue: 0.2, alpha: 1.0)
configuration.titleTextColor = .white
configuration.messageTextColor = .white
    
configuration.buttonConfiguration = NYAlertActionConfiguration()
configuration.buttonConfiguration.titleColor = .white
    
configuration.cancelButtonConfiguration.titleColor = .white
    
// Set up alert actions
let cancelAction = NYAlertAction(title: "Later", style: .cancel, handler: nil)
let okAction = NYAlertAction(title: "Ok", style: .default) { action in
    self.doSomething()
}
    
let alertViewController = NYAlertViewController(options: configuration,
                                                title: title,
                                                message: message,
                                                actions: [cancelAction, okAction])
    
// Optionally add a content view
let iconImageView = UIImageView(image: UIImage(named: "MapIcon"))
iconImageView.contentMode = .scaleAspectFit
iconImageView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
alertViewController.alertViewContentView = iconImageView
    
// Present the alert view controller
self.present(alertViewController, animated: true, completion: nil)
```

## License
This project is released under the MIT License.
