//: Playground - noun: a place where people can play

import UIKit


let familyNames = UIFont.familyNames() as [String]
for familyName in familyNames {
    let fontNames = UIFont.fontNamesForFamilyName(familyName) as [String]
    for fontName in fontNames {
        print(fontName)
    }
}

