//
//  WordObject.swift
//  Wordist
//
//  Created by Aamir  on 10/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit

class WordObject: NSObject {
    let word:String
    let definition:String
    override var description: String {
        return "\(word) \(definition)"
    }
    init(word:String, definition:String) {
        self.word = word
        self.definition = definition
        super.init()
    }
    
    init?(withDictionary responseDict:[String:Any]) {
        guard let word = responseDict["word"] as? String, let definitions = responseDict["defs"] as? [String], let definition = definitions.first else {
            return nil
        }
        self.word = word
        self.definition = WordObject.getSanitizedDefinitionFrom(rawDefinition: definition)
        super.init()
    }
    
    static func getSanitizedDefinitionFrom(rawDefinition:String) -> String {
        var tabCharacterIndex:UInt?
        
        for (i, scalar) in rawDefinition.unicodeScalars.enumerated() {
            if scalar.value == 9 {
                tabCharacterIndex = UInt(i)
            }
        }
        if let tabCharacterIndex = tabCharacterIndex {
            return String.init(rawDefinition.dropFirst(Int(tabCharacterIndex + 1)))
        }
        else {
            return rawDefinition
        }
    }
}
