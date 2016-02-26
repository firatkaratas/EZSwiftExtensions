//
//  StringExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//
import UIKit

extension String {
    
    /// EZSE: Cut string from integerIndex to the end
    public subscript(integerIndex: Int) -> Character {
        let index = startIndex.advancedBy(integerIndex)
        return self[index]
    }
    
    /// EZSE: Cut string from range
    public subscript(integerRange: Range<Int>) -> String {
        let start = startIndex.advancedBy(integerRange.startIndex)
        let end = startIndex.advancedBy(integerRange.endIndex)
        let range = start..<end
        return self[range]
    }
    
    /// EZSE: Character count
    public var length: Int {
        return self.characters.count
    }
    
    /// EZSE: Counts number of instances of the input inside String
    func count(substring: String) -> Int{
        return componentsSeparatedByString(substring).count - 1
    }
    
    /// EZSE: Cut string from given first index to last index
    func substring(firstIndex: Int, lastIndex: Int) -> String {
        let range = startIndex.advancedBy(firstIndex)..<endIndex.advancedBy(lastIndex - characters.count)
        return self[range]
    }

    /// EZSE: Capitalizes first character of String
    public var capitalizeFirst: String {
        var result = self
        result.replaceRange(startIndex...startIndex, with: String(self[startIndex]).capitalizedString)
        return result
    }
    
    /// EZSE: Counts whitespace & new lines
    public func isOnlyEmptySpacesAndNewLineCharacters() -> Bool {
        let characterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        let newText = self.stringByTrimmingCharactersInSet(characterSet)
        return newText.isEmpty
    }
    
    /// EZSE: Trims white space and new line characters
    public mutating func trim() {
         self = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    /// EZSE: Checks if String contains Email
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let firstMatch = dataDetector?.firstMatchInString(self, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.URL?.scheme == "mailto")
    }
    
    /// EZSE: Returns if String is a number
    func isNumber() -> Bool {
        if let _ = NSNumberFormatter().numberFromString(self) {
            return true
        }
        return false
    }
    
    /// EZSE: Extracts URLS from String
    public var extractURLs: [NSURL] {
        var urls : [NSURL] = []
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        } catch _ as NSError {
            detector = nil
        }

        let text = self
        
        detector!.enumerateMatchesInString(text, options: [], range: NSMakeRange(0, text.characters.count), usingBlock: {
            (result: NSTextCheckingResult?, flags: NSMatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            urls.append(result!.URL!)
        })
        
        return urls
    }
    
    /// EZSE: Checking if String contains input
    public func contains(find: String) -> Bool {
        return self.rangeOfString(find) != nil
    }
    
    /// EZSE: Checking if String contains input with comparing options
    public func contains(find: String, compareOption: NSStringCompareOptions) -> Bool {
        return self.rangeOfString(find, options: compareOption) != nil
    }
    
    /// EZSE: Converts String to Int
    public func toInt() -> Int? {
        if let num = NSNumberFormatter().numberFromString(self) {
            return num.integerValue
        } else {
            return nil
        }
    }
    
    /// EZSE: Converts String to Double
    public func toDouble() -> Double? {
        if let num = NSNumberFormatter().numberFromString(self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// EZSE: Converts String to Float
    public func toFloat() -> Float? {
        if let num = NSNumberFormatter().numberFromString(self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    /// EZSE: Converts String to Bool
    func toBool() -> Bool? {
        let trimmed = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).lowercaseString
        if trimmed == "true" || trimmed == "false" {
            return (trimmed as NSString).boolValue
        }
        return nil
    }
    
    ///EZSE: Returns the first index of the occurency of the character in String
    public func getIndexOf(char: Character) -> Int? {
        for (index, c) in characters.enumerate() {
            if c == char {
                return index
            }
        }
        return nil
    }
    
    /// EZSE: Converts String to NSString
    public var toNSString: NSString { get { return self as NSString } }
    
    ///EZSE: Returns bold NSAttributedString
    func bold() -> NSAttributedString {
        let boldString = NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(UIFont.systemFontSize())])
        return boldString
    }
  
    ///EZSE: Returns underlined NSAttributedString
    func underline() -> NSAttributedString {
        let underlineString = NSAttributedString(string: self, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
        return underlineString
    }
  
    ///EZSE: Returns italic NSAttributedString
    func italic() -> NSAttributedString {
        let italicString = NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: UIFont.italicSystemFontOfSize(UIFont.systemFontSize())])
        return italicString
    }
  
    ///EZSE: Returns NSAttributedString
    func color(color: UIColor) -> NSAttributedString {
        let colorString = NSMutableAttributedString(string: self, attributes: [NSForegroundColorAttributeName: color])
        return colorString
    }
    
}

