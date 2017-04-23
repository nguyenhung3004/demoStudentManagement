//
//  StudentsTableViewController.swift
//  demoStudentsManagement
//
//  Created by Hung Nguyen on 4/15/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController {

    
    @IBOutlet var nodataView: UIView!
    
    @IBOutlet weak var footer: UIView!
    
    
    private var hasNoData: Bool = false {
        didSet {
            guard hasNoData != oldValue else{return}
            if self.hasNoData{
                self.tableView.tableFooterView = nodataView
                self.tableView.isScrollEnabled = false
                self.editButtonItem.isEnabled = false
            }
            else {
                self.tableView.tableFooterView = footer
                self.tableView.isScrollEnabled = true
                self.editButtonItem.isEnabled = true
            }
            self.setEditing(false, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nodataView.frame = view.frame
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        hasNoData = DataServices.shared.students.count == 0
    }

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataServices.shared.students.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StudentCell
        let student = DataServices.shared.students[indexPath.row]
        
        cell.nameLabel.text = student.name
        cell.phoneNumber.text = student.phoneNum
        cell.avatarImage.image = student.image
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            DataServices.shared.removeStudent(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            hasNoData = DataServices.shared.students.count == 0
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        DataServices.shared.reorderStudents(fromIndex: fromIndexPath.row, toIndex: to.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "showDetails":
            guard let studentDetailsVC = segue.destination as? StudentsVC else {
                fatalError("Unexpacted destination: \(segue.destination)")
            }
            guard let selectedStudentCell = sender as? StudentCell else {
                fatalError("unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedStudentCell) else {
                fatalError("The selected cell is not being display the table")
            }
            studentDetailsVC.selectedStudentIndex = indexPath.row
        default:
            return
        }
    }
    
//    @IBAction func passDataByUnwind(unwind: UIStoryboardSegue){
//        if let studentVC = unwind.source as? StudentsVC{
//            guard let student = StudentModal(name: studentVC.nameTextField1.text!, phoneNum: studentVC.nameTextField2.text!) else {return}
//            DataServices.shared.students.append(student)
//            tableView.reloadData()
//        }
//    }

}
