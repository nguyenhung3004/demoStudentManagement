//
//  DataServices.swift
//  demoStudentsManagement
//
//  Created by Hung Nguyen on 4/15/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation
import  os.log

class DataServices {
    static let shared: DataServices = DataServices()
    private var _students: [StudentModal]?
    var students: [StudentModal] {
        get{
            if _students == nil{
                updateStudents()
            }
            return _students ?? []
        }
        set{
            _students = newValue
        }
    }
    
    func updateStudents(){
        _students = NSKeyedUnarchiver.unarchiveObject(withFile: StudentModal.ArchiveURL.path) as? [StudentModal]
    }
    
    private func saveStudents(){
        guard _students != nil else {return}
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(_students!, toFile: StudentModal.ArchiveURL.path)
        if isSuccessfulSave{
            os_log("Student successfully save", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Failed to save Student...", log: OSLog.default, type: .error)
        }
        
    }
    func reorderStudents(fromIndex: Int, toIndex: Int){
        guard fromIndex != toIndex else {
            return
        }
//        swap(&_students![fromIndex], &_students![toIndex])
        let temp = _students?.remove(at: fromIndex)
        _students?.insert(temp!, at: toIndex)
    }
    
    func removeStudent(at index: Int){
        _students?.remove(at: index)
        saveStudents()
    }
    
    func appendStudent(student: StudentModal){
        guard student != nil else {return}
        if _students == nil{
            _students = []
        }
        _students?.insert(student, at: 0)
        saveStudents()
    }
    func replace(student: StudentModal, at index : Int){
        _students![index] = student
        saveStudents()
    }
}
