//: Playground - noun: a place where people can play

import UIKit

func sizeHeightWithText(labelText: NSString, fontSize: CGFloat, textAttributes: [NSObject: AnyObject]) -> CGRect {
    return labelText.boundingRectWithSize(CGSizeMake(fontSize, 480), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textAttributes, context: nil)
}

//"Anevir"
extension UILabel {
    convenience init(fontName: String, labelText: String, fontSize: CGFloat) {
        let font = UIFont(name:fontName, size: fontSize) as UIFont!
        
        let textAttributes: [NSObject: AnyObject] = [NSFontAttributeName: font]
        var labelSize = sizeHeightWithText(labelText, fontSize, textAttributes)

        self.init(frame: labelSize)
        self.attributedText = NSAttributedString(string: labelText, attributes: textAttributes)

        self.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.numberOfLines = 0
    }
}

var newLabel = UILabel()
newLabel.text = "heylabel"
newLabel.sizeToFit()
newLabel

var label = UILabel(fontName: "Avenir", labelText: ", fontSize: <#CGFloat#>)