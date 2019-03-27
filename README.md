# Swift-Utils

<p align="center">
<img src="https://github.com/amrit42087/Swift-Utils/blob/master/video.gif" width="30%" height="30%" alt="Gif Preview" />
</p>

<p align="center">
<img src="https://img.shields.io/badge/Platform-iOS_10+-green.svg" alt="Platform: iOS 10.0+" />
<a href="https://developer.apple.com/swift" target="_blank"><img src="https://img.shields.io/badge/Language-Swift_4-blueviolet.svg" alt="Language: Swift 4" /></a>
<a href="https://cocoapods.org/pods/PanModal" target="_blank"><img src="https://img.shields.io/badge/CocoaPods-v1.0-red.svg" alt="CocoaPods compatible" /></a>
<img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT" />
</p>

<p align="center">
 <a href="#requirements">Requirements</a>
• <a href="#usage">Usage</a>
• <a href="#installation">Installation</a>
• <a href="#author">Author</a>
• <a href="#license">Liscence</a>
</p>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Swift-Utils requires **iOS 10+** and is compatible with **Swift 4.2** projects.

## Usage

Swift Utils can be used to simplify various tasks. They are actually an extension to your UIView, UIViewController, NSObject etc.

### UIView Extensions

#### Draw shadow with round corners

```
view.shadowWithRoundCorner(cornerRadius: 10)
```

#### Create round corner of a UIView from certain corners

```
view.roundCorners([UIRectCorner.bottomLeft, UIRectCorner.topLeft], radius: 10)
```

####  Add a dashed border to a UIView

```
view.dashedBorder(borderColor: .black, lineDashPattern: [2,2])
```

#### Add any View as a popup in a controller

```
You can alter the animation directiona and position of the pop up. 

// If you pass nil in controller, pop up will be added to UIWindow, else into the controller 
view.addIn(nil, addFrom: .top, position: .center)
```

#### Get parentController of a UIView

```
let parentController = view.parentContainerViewController()
```

#### Getting the top most controller from a UIView

```
self.view.topControllerInHierarchy()
```

### Add/Remove loader to/from any UIView component

```
view.lock()
button.lock()

view.unlock()
button.unlock()
```

###### You can customize the loader either using the Appearance class or by passing the parameters in the lock() function. For Example to cahnge the loader stle using Appearance class, simple add these lines in AppDelegate:

```
ASLoader.appearance().tintColor = .red
ASLoader.appearance().textColor = .white
ASLoader.appearance().font = UIFont.systemFont(ofSize: 12.0)
ASLoader.appearance().size = CGSize(width: 40, height: 40)
```

###### Customize loader by passing parameters. You are not required to pass all paramters. Just pass the ones, that you need to customize.

```
self.view.lock(text: "loading",
    tintColor: .red, textColor: .white,
    font: UIFont.systemFont(ofSize: 16),
    centerImage: UIImage(named: "logo"),
    size: CGSize(width: 30, height: 30))
```

### Show toast

```
self.showToast(message: "Success")
```

###### You can customise the toast either using appearance class or by passing parameters:

```
ASToast.appearance().toastBackgroundColor = .black
ASToast.appearance().textColor = .white

self.showToast(message: "Success",
    backgroundColor: .black, textColor: .white,
    font: UIFont.systemFont(ofSize: 16))
```

### Customizable View

#### Simply add a view in storyboard and assign it the class "ASCustomizableView". This is best when you want round corners with shadow.  You can then alter cretain properties from the attribute inspector such as: 

```
showShadow // If true shadow will be drawn. If false, you can changes attributes like corner radius, border width and color etc. 
borderColor
borderWidth
shadowRadius
shadowOpacity
cornerRadius
shadowColor
shadowOffset
```

### String extensions:

#### These extensions can help you validate strings for a valid email, valid text, valid phoneNumber etc.

```
let myString = "amrit@gmail.com"

if myString.isBlank {
    print("success")
}

if myString.isEmail {
    print("success")
}

if myString.isAlphanumeric {
    print("success")
}

if myString.isValidPassword {
    print("success")
}

if myString.isPhoneNumber {
    print("success")
}

```

### UIColor Extensions

#### Get UIColor from hexString or hex intValue

```
let colorFromString = UIColor.hexColor("FF0000")
let colorFromInt = UIColor(rgb: 0xFF0000)
```

### UIDate Extensions

#### Date extensions are be used for comparing dates, getting stringFormats from date or getting timeStamps etc:

```
let date1 = Date()

let date2 = Date()

if date1.isGreaterThanDate(date: date2) {

}

if date1.isLessThanDate(date: date2) {

}

if date1.isEqualToDate(date: date2) {

}

let stringDate = date1.toDateString()

let stringDate2 = date1.toDateString(format: "yyyy-MM-dd", timezone: TimeZone(identifier: "UTC"))

// This method will return the time span between the date1 and current time. This is an ease for 
//showing timestamp in applications like social timeline or chatting applications.
let time = date1.timeAgoValue() // returns "1 min Ago"

```

### UITableView Extensions

#### Handle empty tableview easily

```
let tableView = UITableView()

// Add no Data text for empty table
tableView.handleEmptyTable(text: "No Data")

// Remove no Data text
tableView.handleEmptyTable(text: nil)

// Get index of an view inside a UITableViewCell
let indexPath = tableView.indexPath(for: sender) // Sender can be anything. UIView/UIButton/UILabel etc
```

### UITableViewCell Extensions

#### Get tableView from the UITableViewCell. This is useful when you want to get the reference of UITableview inside the UITableViewCell class.

```
let tableView = cell.tableView
```

### UIViewController Extensions

#### Handle navigation back button easily using these simple extension

```
/// This hides the backButton title for the next controller
self.hideBackButtonTitle()

// This removes the back button from the navigation bar
self.removeBackButton()

/// You can set a custom back button using this extension
self.setCustomBackButton(image: UIImage(named: "back"))

// Show an alert from a controller
self.showAlert(title: "Alert", message: "Success", style: .alert)
```


## Installation

Swift-Utils is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Swift-Utils'
```

## Author

amrit42087, amritsidhu88@gmail.com

## License

Swift-Utils is available under the MIT license. See the LICENSE file for more info.
