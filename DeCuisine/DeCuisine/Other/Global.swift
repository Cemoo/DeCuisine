//
//  Global.swift
//
//  Created by Erencen Evren on 2.03.2018.
//  Copyright © 2018 DreamsAndBytes. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import MapKit

//ERROR TEXTS

let internetGoneError: String = "Lütfen internet bağlantınızı kontrol ediniz"
let timeOutError: String = "Servis zaman aşımına uğradı"
var appIsClosing: Bool = false

var isComingFromCustomURL = false

func UIColorFromRGB(_ rgbValue: UInt, _ alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

/**
 Delays the operation in it.
 
 - Parameter seconds: Delay duration in seconds.
 - Parameter fn: Completion function
 
 ### Usage Example: ###
 ````
 delay(0.4){
 *Operation in here will be executed after 0.4 seconds reading function.*
 }
 ````
 
 - Returns: None.
 */
func delay(_ seconds: Double, fn: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(seconds * 1000.0)), execute: fn)
}

/// Holds device width
var deviceWidth = 0
/// Holds device height
var deviceHeight = 0

/**
 Gets device width
 
 - Returns: CGFLoat
 */
func getWidth() -> CGFloat {
    return CGFloat(deviceWidth)
}

/**
 Gets device height
 
 - Returns: CGFLoat
 */
func getHeight() -> CGFloat {
    return CGFloat(deviceHeight)
}

/**
 Sets deviceWidth and deviceHeight parameters for further use.
 
 ## Important ##
 * Use this function in the first view controller's didLoad funtion.
 
 - Parameter width: Device width
 - Parameter height: Device height
 
 ### Usage Example: ###
 ````
 setDeviceBounds(Int(self.view.bounds.width), height: Int(self.view.bounds.height))
 ````
 
 - Returns: None.
 */
func setDeviceBounds(_ width: Int, height: Int) {
    deviceWidth = width
    deviceHeight = height
}

/**
 Shows a hidden view with basic animation
 
 - Parameter view: A view to be shown
 
 ### Usage Example: ###
 ````
 showViewWithAnimation(view)
 ````
 
 - Returns: None.
 */
func showViewWithAnimation(_ view: UIView){
    UIView.transition(with: view, duration: 0.33, options: .transitionCrossDissolve, animations: {
        view.isHidden = false
    }, completion: nil)
    
}

/**
 Hides a visible view with basic animation
 
 - Parameter view: A view to be hidden
 - Parameter isExternalView: User can inform function about the view. If true view is need to be removed from superview.
 
 ### Usage Example: ###
 ````
 hideViewWithAnimation(view)
 ````
 
 - Returns: None.
 */
func hideViewWithAnimation(_ view: UIView, isExternalView: Bool = false) {
    UIView.transition(with: view, duration: 0.33, options: .transitionCrossDissolve, animations: {
        if isExternalView {
            view.alpha = 0
        } else {
            view.isHidden = true
        }
    }) { (isFin) in
        if isExternalView {
            view.removeFromSuperview()
        }
    }
}

/**
 Sets transparency of the views
 
 - Parameter value: Tranparency value
 
 ### Usage Example: ###
 ````
 setAlpha(0, view: view)
 ````
 
 - Returns: None.
 */
func setAlpha(_ value: CGFloat, view: UIView, completion: (()->())? = nil) {
    UIView.transition(with: view, duration: 0.33, options: .transitionCrossDissolve, animations: {
        view.alpha = value
    }) { (isFin) in
        completion?()
    }
}

/**
 Gets system time
 
 - Returns: String time Ex: 11:35
 */
func getSystemTime() -> String {
    let date = Date()
    let calendar = Calendar.current
    let components = (calendar as NSCalendar).components([.hour, .minute], from: date)
    let hour = components.hour
    let minutes = components.minute
    return "\(hour!):\(minutes!)"
}

/**
 Gets system date
 
 - Returns: String date Ex: 2017-03-16
 */
func getSystemDate() -> String {
    let date = Date()
    let calendar = Calendar.current
    let components = (calendar as NSCalendar).components([.year, .month, .day], from: date)
    let year = components.year
    let month = components.month
    let day = components.day
    return "\(year!)-\(month!)-\(day!)"
}

/**
 Checks if internet is available
 
 - Returns: Bool
 */
func isInternetAvailable() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}

/**
 Generates and presents a connection alert.
 
 - Parameter self: View controller which will present the alert
 
 - Returns: None.
 */
func generateConnectionAlert(_ _self: UIViewController) {
    let alertController = UIAlertController(title: "Error", message:
        "", preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    _self.present(alertController, animated: true, completion: nil)
    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
    alertWindow.rootViewController = UIViewController()
    alertWindow.windowLevel = UIWindowLevelAlert + 1;
    alertWindow.makeKeyAndVisible()
    alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
}

/**
 Checks if given email text is a valid email.
 
 - Parameter testStr: A string which will be checked for email validation.
 
 - Returns: Bool
 */
func isValidEmail(_ testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr.trimmingCharacters(in: .whitespacesAndNewlines))
}

/**
 Checks if given text contains a special char like Turkish.
 
 - Parameter text: A string which will be checked for validation.
 
 - Returns: Bool
 */
func isContainsSpecialCharacters(_ text:String) -> Bool {
    let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    if text.rangeOfCharacter(from: characterset.inverted) != nil {
        return false
    }
    else {
        return true
    }
    
}

/**
 Generates a custom alert
 
 - Parameter title: Title of the custom alert controller.
 - Parameter message: Text for explaining the situation to the user.
 - Parameter buttonText: Button text.
 
 ### Usage Example: ###
 ````
 let alert = genericAlert("Warning", message: "Hello user!", buttonText: "Ok")
 self.present(alert, animated: true, completion: nil)
 ````
 
 - Returns: UIAlertController
 */
func genericAlert(_ title: String, message: String, buttonText: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
    return alert
}

/**
 Simple date formatter.
 
 - Parameter date: Date which we want to format, Date type.
 - Parameter format: String format which we want to format the date. *Default "dd/MMM/YYYY"*
 
 ### Usage Example: ###
 ````
 label.text = stringFrom(date)
 label.text = stringFrom(date, "MMM/dd/YYYY")
 ````
 
 - Returns: String
 */
func stringFrom(_ date: Date, format: String = "dd/MMM/YYYY") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    let dateString = dateFormatter.string(from: date)
    return dateString
}

/**
 Returns number from string.
 
 - Parameter from: String which will be returned to a number.
 
 ### Usage Example: ###
 ````
 let count = getNumber(from: "10")
 ````
 
 - Returns: AnyObject
 */
func getNumber(_ from: String) -> AnyObject {
    let str = from.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let numberFormatter = NumberFormatter()
    let number = numberFormatter.number(from: str)
    return number!
}

/**
 Returns string from number.
 
 - Parameter number: Any number.
 
 ### Usage Example: ###
 ````
 let str = stringFrom(number: 12)
 ````
 
 - Returns: String
 */
func stringFrom(number: Any) -> String {
    return "\(number)"
}

/**
 Localized string for given key
 
 - Parameter withKey: The key we stored in the localizable strings.
 
 ### Usage Example: ###
 ````
 let str = localize("done")
 ````
 
 - Returns: String
 */
func localize(_ withKey: String) -> String {
    return NSLocalizedString(withKey, comment: "cmnt")
}

/**
 Converts image to byte array
 
 - Parameter image: Image which will be converted to byte array.
 - Parameter compression: Compression rate for image.
 
 - Returns: [UInt8]
 */
func convertImageToByteArray(image: UIImage, compression: CGFloat) -> [UInt8] {
    let data: Data = UIImageJPEGRepresentation(image, compression)!
    let count = data.count / MemoryLayout<UInt8>.size
    var array = [UInt8](repeating: 0, count: count)
    data.copyBytes(to: &array, count:count * MemoryLayout<UInt8>.size)
    return array
}

/**
 Crops image to square
 
 - Parameter image: Image which will be cropped.
 - Parameter width: Width after crop.
 - Parameter height: Height after crop.
 
 - Returns: UIImage
 */
func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
    let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
    let contextSize: CGSize = contextImage.size
    var posX: CGFloat = 0.0
    var posY: CGFloat = 0.0
    var cgwidth: CGFloat = CGFloat(width)
    var cgheight: CGFloat = CGFloat(height)
    // See what size is longer and create the center off of that
    if contextSize.width > contextSize.height {
        posX = ((contextSize.width - contextSize.height) / 2)
        posY = 0
        cgwidth = contextSize.height
        cgheight = contextSize.height
    } else {
        posX = 0
        posY = ((contextSize.height - contextSize.width) / 2)
        cgwidth = contextSize.width
        cgheight = contextSize.width
    }
    let rect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
    // Create bitmap image from context using the rect
    let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
    // Create a new image based on the imageRef and rotate back to the original orientation
    let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
    return image
}

func duupleShadow(_ yPosition: CGFloat) -> UIView {
    let shadowView = UIView(frame: CGRect(x: 0, y: 2, width: CGFloat(deviceWidth), height: 62.5))
    shadowView.backgroundColor = UIColor.white
    shadowView.isUserInteractionEnabled = false
    shadowView.layer.masksToBounds = false
    shadowView.layer.shadowColor = UIColorFromRGB(0xA9ACBD).cgColor
    shadowView.layer.shadowOpacity = 0.25
    shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
    shadowView.layer.shadowRadius = 5
    return shadowView
}

/**
 Sets a shadow for a view
 
 - Parameter view: View which will have the basic shadow.
 - Parameter path: UIBezierPath typed path of the shadow.
 - Parameter opacity: Alpha value of the shadow.
 - Parameter shadowOffset: Dimensions of the shadow.
 - Parameter radius: Radius value is the gradiendt width value shadow.
 - Parameter shadowColor: Color of the shadow, default black.
 
 - Returns: None.
 */
func setShadowFor(_ view: UIView, path: UIBezierPath, opacity: Float, shadowOffset: CGSize, radius: CGFloat, shadowColor: CGColor = UIColor.black.cgColor) {
    let shadowPath = path
    view.layer.shadowColor = shadowColor
    view.layer.shadowOpacity = opacity
    view.layer.shadowOffset = shadowOffset
    view.layer.shadowRadius = radius
    view.layer.shadowPath = shadowPath.cgPath
    view.layer.shouldRasterize = true
}

/**
 Sets a basic shadow for a view
 
 - Parameter view: View which will have the basic shadow.
 
 - Returns: None.
 */
func basicShadowFor(_ view: UIView) {
    let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: view.frame.width + 50, height: view.frame.height + 50))
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.3
    view.layer.shadowOffset = CGSize(width: 0, height: 1.9)
    view.layer.shadowRadius = 3
    view.layer.shadowPath = shadowPath.cgPath
}

func backDaysString(_ components: DateComponents, _ timeZoneOffset: Int) -> String {
    if let days = components.day {
        if days < 30 {
            if days < 1 {
                if let hours = components.hour {
                    if hours - timeZoneOffset < 1 {
                        if let minutes = components.minute {
                            if minutes < 1 {
                                if let secs = components.second {
                                    if secs == 0 {
                                        return "now"
                                    }
                                    return "\(secs) sec. ago"
                                } else {
                                    return "\(minutes) min. ago"
                                }
                            } else {
                                return "\(minutes) min. ago"
                            }
                        } else {
                            if hours == 1 {
                                return "\(hours) hour ago"
                            }
                            return "\(hours) hours ago"
                        }
                    } else {
                        if hours == 1 {
                            return "\(hours) hour ago"
                        }
                        return "\(hours) hours ago"
                    }
                } else {
                    if days == 1 {
                        return "\(days) day ago"
                    }
                    return "\(days) days ago"
                }
            } else {
                if days == 1 {
                    return "\(days) day ago"
                }
                return "\(days) days ago"
            }
        } else {
            let months: Int = days / 30
            if months > 1 {
                return "\(months) months"
            }
            return "1 month"
        }
    } else {
        return ""
    }
}

func calculateBackDays(_ date: String) -> String {
    let now = Date()
    let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: now))
    print(timeZoneOffset)
    let timeZoneOffSetHours = timeZoneOffset / 3600
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .iso8601)
    if date.contains(".") {
        let dd = date
        let ddd = dd.split(separator: ".")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let createDate = dateFormatter.date(from: String(ddd[0]))
        if let createDateToOffset = createDate {
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.day, .hour, .minute, .second], from: createDateToOffset, to: now)
            return backDaysString(components, Int(timeZoneOffSetHours))
        } else {
            return ""
        }
    } else {
        return ""
    }
}

func resizeImage(_ image: UIImage, size: CGSize) -> UIImage {
    let bsize = image.size
    let widthRatio  = size.width  / bsize.width
    let heightRatio = size.height / bsize.height
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: bsize.width * heightRatio, height: bsize.height * heightRatio)
    } else {
        newSize = CGSize(width: bsize.width * widthRatio,  height: bsize.height * widthRatio)
    }
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}

/**
 Sets the back item title to a given value
 
 - Parameter title: Back item text.
 
 - Returns: UIBarButtonItem
 */
func setBackItem(_ title: String) -> UIBarButtonItem {
    let backItem = UIBarButtonItem()
    backItem.title = title
    return backItem
}

/**
 Fixes the orientation issue after capture
 
 - Parameter img: Disoriented image.
 
 - Returns: UIImage
 */
func fixOrientation(img: UIImage) -> UIImage {
    if (img.imageOrientation == .up) {
        return img
    }
    
    UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
    let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
    img.draw(in: rect)
    
    let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return normalizedImage
}

/**
 Fixes the orientation issue after capture
 
 - Parameter img: Disoriented image.
 
 - Returns: UIImage
 */
func fixLocations(str: String) -> String {
    var stri = str
    var counter = 0
    for _ in str {
        counter += 1
        if counter > 8 {
            stri.removeLast()
        }
    }
    return stri
}



/**
 returns formatted version of money to US Locale
 
 - Parameter amount : amount of money in NSNumber
 
 - Returns: String
 */
func format(amount: NSNumber) -> String{
    let formatter = NumberFormatter()
    formatter.locale = Locale.init(identifier: "en_US")
    formatter.numberStyle = .currency
    if let str = formatter.string(from: amount) {
        return str
    }else {
        return "$0"
    }
}


/**
 returns formatted version of money to US Locale
 
 - Parameter amount : amount of money in Double
 
 - Returns: String
 */
func format(amount: Double) -> String{
    let value = NSNumber(value: amount)
    return format(amount: value)
    //    }else {
    //        return "$0"
    //    }
}


/**
 returns share url and text for challenge or proof
 
 - Parameter text : congs text
 
 -Parameter: url: post url for challenge or proof
 
 */


/**
 
 Logs analytics event
 
 */


func validatePassword(_ pass: String) -> Bool {
    if pass.count >= 6 {
        if regexControl(pass) {
            return true
        } else {
            return false
        }
    } else {
        return false
    }
}

func regexControl(_ str: String) -> Bool{
    let regEx = "^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])([\\S]*)$"
    let test = NSPredicate(format:"SELF MATCHES %@", regEx)
    return test.evaluate(with: str)
}

func differenceBetween(_ startDate: String, _ endDate: String) -> Bool {
    
    //2018-29-01T21:58+03:00
    //2018-01-30T23:58+03:00
    
    var diffDay = 0
    let dateFormatter = DateFormatter()
    let userCalendar = Calendar.current
    let requestedComponent: Set<Calendar.Component> = [.month,.day,.hour,.minute,.second]
    
    dateFormatter.dateFormat = "yyyy-dd-MM'T'HH:mm+03:00"
    let startdate = dateFormatter.date(from: startDate)
    let enddate = dateFormatter.date(from: endDate)
    
    if let end = enddate, let start = startdate {
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: start, to:end)
        if let day = timeDifference.day {
            print(timeDifference.day!)
            diffDay = day
        }
    }
    
    if diffDay < 1 {
        return false
    }
    return true
    
}

func fixDateForServiceFormat(_ date: String) -> String {
    //2018-29-01T15:50+03:00
    //will return  2018-01-29T15:50+03:00
    var resultDate = ""
    let array = date.components(separatedBy: "T")[0].components(separatedBy: "-")
    if array.count != 0 {
        let rightSideFromT = date.components(separatedBy: "T")[1]
        resultDate =  "\(array[0])-\(array[2])-\(array[1])T\(rightSideFromT)"
    }
    
    return resultDate
    
}

func beginingWithZero(_ price: String) -> Bool {
    if price != "" {
        let arr = Array(price)
        if arr[0] == "0" {
            return true
        } else {
            return false
        }
    } else {
        return false
    }
    
}

func containsLetterChar(_ price: String) -> Bool {
    if price != "" {
        if price.contains(",") == false {
            if Int(price) == nil {
                return true
            } else {
                return false
            }
        } else {
            if Int(price.replacingOccurrences(of: ",", with: "")) == nil {
                return true
            } else {
                return false
            }
        }
       
    } else {
        return false
    }
}

func containsSpecialChar(_ text: String) -> Bool {
    if text != "" {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        if text.rangeOfCharacter(from: characterset.inverted) == nil {
            return true
        } else {
            return false
        }
    } else {
        return false
    }
}

//func decideRootController() -> UIViewController? {
//    var rootViewController = UIApplication.shared.keyWindow?.rootViewController
//    if (rootViewController as? UINavigationController) == nil && (rootViewController as? UITabBarController) == nil {
//        return UIApplication.input
//    } else {
//        if let navigationController = rootViewController as? UINavigationController {
//            rootViewController = navigationController.viewControllers.first
//        }
//        if let tabBarController = rootViewController as? UITabBarController {
//            rootViewController = tabBarController.selectedViewController
//        }
//        return rootViewController
//    }
//}


