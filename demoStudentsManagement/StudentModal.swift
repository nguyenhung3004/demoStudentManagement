//
//  StudentModal.swift
//  demoStudentsManagement
//
//  Created by Hung Nguyen on 4/15/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class StudentModal: NSObject, NSCoding {
    
    var name: String
    var phoneNum: String
    var image: UIImage?
    
    
    init?(name: String, phoneNum: String, image: UIImage?){
        guard name != "" else { return nil }
        var isNameHaveNumber: Bool = false
        for str in name.characters.map({String ($0)}){
            if Int(str) != nil{
                isNameHaveNumber = true
                break
            }
        }
        guard isNameHaveNumber == false else {return nil}
        let phoneNumberTrimmed = phoneNum.trimmingCharacters(in: .whitespacesAndNewlines)
        guard [10,11].contains(phoneNumberTrimmed.characters.count) else { return nil}
        guard Int(phoneNumberTrimmed) != nil else {return nil}
        self.name = name
        self.phoneNum = phoneNum
        self.image = image
        
    }
    
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("students")
    
    struct  PropertyKey {
        static let name = "name"
        static let phoneNum = "phoneNum"
        static let image = "image"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(phoneNum, forKey: PropertyKey.phoneNum)
        aCoder.encode(image, forKey: PropertyKey.image)
        
    }
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        let phoneNum = aDecoder.decodeObject(forKey: PropertyKey.phoneNum) as! String
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as! UIImage
        self.init(name: name, phoneNum: phoneNum, image: image)
    }
}
