//
//  String+Extention.swift
//  Hosee
//
//  Created by Duc Anh on 4/12/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

extension String {
    var toDate: Date {
        get {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormater.locale = Locale(identifier: "vi_VN")
            let date = dateFormater.date(from: self)
            return date!
        }
    }
    
}

extension String {
    
    var localized: String {
        var currentLocale = "Base"
        if let locate = UserDefaults.standard.object(forKey: "locate") as? String {
            currentLocale = locate
        }
        guard
            let bundlePath = Bundle.main.path(forResource: currentLocale, ofType: "lproj"),
            let bundle = Bundle(path: bundlePath) else {
                return self
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func isYoutubeLink() -> Bool {
        return contains("www.youtube.com")
    }
    
    
    var isPhoneNumber: Bool {
        guard self.count == 10 else {
            showAlert(title: "Lỗi", message: "Số điện thoại đúng cần 10 ký tự")
            return false
        }
        
        let character  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: character)
        let filtered = inputString.joined(separator: "")
        return self == filtered
    }
    
    var isNullOrEmpty: Bool {
        guard self.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {return false}
        return true
    }
    var isValidEmail : Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var dType: String {
        let price = self
        let priceNumber = price.split(separator: " ").first
        let priceStringWithD = "\(priceNumber ?? "")đ"
        return priceStringWithD
    }
    
    func subString(with param: String) -> (first: String, last: String) {
        var afterEqualsTo = ""
        var beforeEqualsToContainingSymbol = ""
        if let index = (self.range(of: param)?.upperBound) {
            afterEqualsTo = String(self.suffix(from: index)) //prints "value"
            beforeEqualsToContainingSymbol = String(self.prefix(upTo: index)) //prints "element="
        }
        return (first: beforeEqualsToContainingSymbol, last: afterEqualsTo)
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes: [NSAttributedString.Key : Any] = [kCTFontAttributeName as NSAttributedString.Key: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func localizable() -> String {
        return NSLocalizedString(self, comment: "no-comment")
    }
    
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes: [NSAttributedString.Key : Any] = [kCTFontAttributeName as NSAttributedString.Key: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    var html2AttributedString: NSAttributedString? {
        
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            //            print(attributedString)
            return attributedString
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    var removeLastBreakLine: String {
        var text = self
        if text.last == "\n" {
            text = String(text.dropLast())
        }
        return text
    }
}
extension NSMutableAttributedString {
    func setColorForText(_ textToFind: String?, with color: UIColor) {
        
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range!)
        }
    }
}

// MARK: - extension Optional String



extension Optional where Wrapped == String  {
    var isPhoneNumber: Bool {
        guard let string = self else {
            return false
        }
        return string.isPhoneNumber
    }
    
    var isNullOrEmpty: Bool {
        guard let string = self else {
            return false
        }
        return string.isNullOrEmpty
    }
    var isValidEmail : Bool {
        guard let string = self else {
            return false
        }
        return string.isValidEmail
    }
}
