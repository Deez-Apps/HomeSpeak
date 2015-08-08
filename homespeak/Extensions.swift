//
//  Extensions.swift
//  Selfik
//
//  Created by Eugene Yurtaev on 01/07/15.
//  Copyright (c) 2015 dpfbop. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func setNavigationBarTitleWithCustomFont(title: String) {
        var size = UIFont(name: "Avenir Next", size: 18)?.sizeOfString(title, constrainedToWidth: 200)
        var label = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size!))
        label.text = title
        label.font = UIFont(name: "Avenir Next", size: 18)
        self.navigationItem.titleView = label
    }
}


extension UIColor
{
    convenience init(r: Int, g: Int, b: Int, a: Int)
    {
        let newRed   = CGFloat(Double(r) / 255.0)
        let newGreen = CGFloat(Double(g) / 255.0)
        let newBlue  = CGFloat(Double(b) / 255.0)
        let newAlpha = CGFloat(Double(a) / 100.0)
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
    }
}

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}

extension UIFont {
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return (string as NSString).boundingRectWithSize(CGSize(width: width, height: DBL_MAX),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self],
            context: nil).size
    }
}

func +(a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPoint(x: a.x + b.x, y: a.y + b.y)
}

func -(a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPoint(x: a.x - b.x, y: a.y - b.y)
}

func degreesToRadians(alpha: Double) -> Double {
    return (alpha / 180.0) * M_PI
}

func reverse(string: String) -> String {
    var reverseStr = ""
    
    for character in string {
        reverseStr = String(character) + reverseStr
    }
    return reverseStr
}

extension UIImage {
    func averageColor() -> UIColor {
        let rgba = UnsafeMutablePointer<CUnsignedChar>.alloc(4)
        let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()
        let info = CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context: CGContextRef = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, info)
        
        CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage)
        
        if rgba[3] > 0 {
            
            let alpha: CGFloat = CGFloat(rgba[3]) / 255.0
            let multiplier: CGFloat = alpha / 255.0
            
            return UIColor(red: CGFloat(rgba[0]) * multiplier, green: CGFloat(rgba[1]) * multiplier, blue: CGFloat(rgba[2]) * multiplier, alpha: alpha)
            
        } else {
            
            return UIColor(red: CGFloat(rgba[0]) / 255.0, green: CGFloat(rgba[1]) / 255.0, blue: CGFloat(rgba[2]) / 255.0, alpha: CGFloat(rgba[3]) / 255.0)
        }
    }
}


extension UIView {
    
    func pb_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        
        drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        
        // old style: layer.renderInContext(UIGraphicsGetCurrentContext())
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIViewController {
    func isIpad() -> Bool {
        if self.traitCollection.userInterfaceIdiom == .Phone {
            return false
        } else {
            return true
        }
    }
}

extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f", self) as String
    }
}

extension NSDate {
    func standartTime() -> String {
        var formatter = NSDateFormatter()
        var formatString = NSDateFormatter.dateFormatFromTemplate("HH:mm:ss", options: 0, locale: NSLocale(localeIdentifier: "en_US_POSIX"))
        formatter.dateFormat = formatString
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return formatter.stringFromDate(self)
    }
    
    func standartDateTime() -> String {
        var formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle =  .MediumStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return formatter.stringFromDate(self)
    }
}

extension Double {
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension Int {
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}


extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}
