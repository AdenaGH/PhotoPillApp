//
//  TableViewController.swift
//  PhotoPill
//
//  Created by Adena Ninvalle on 4/10/23.
//

import Foundation
import UIKit

class TableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    
    @IBOutlet weak var pillTableView: UITableView!
    
    var pillList = [Pill]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initList()
    }
    
    func initList() {
        let pill1 = Pill(name: "Chill Pill", description: "Taken for the user to chill out.", imageName: "pill1")
        pillList.append(pill1)
        
        let pill2 = Pill(name: "Chill Pill", description: "Taken for the user to chill out.", imageName: "pill2")
        pillList.append(pill2)
        
        let pill3 = Pill(name: "Chill Pill", description: "Taken for the user to chill out.", imageName: "pill3")
        pillList.append(pill3)
        
        let pill4 = Pill(name: "Chill Pill", description: "Taken for the user to chill out.", imageName: "pill4")
        pillList.append(pill4)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pillList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID") as! TableViewCell
        
        let thisPill = pillList[indexPath.row]
        
        tableViewCell.pillName.text = thisPill.name
        
        tableViewCell.pillDescription.text = thisPill.description
        
        tableViewCell.pillImage.image = UIImage(named: thisPill.imageName)
        
        return  tableViewCell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            let indexPath = self.pillTableView.indexPathForSelectedRow!
            
            let tableViewDetail = segue.destination as? TableViewDetail
            
            let selectedPill = pillList[indexPath.row]
            
            tableViewDetail!.selectedPill = selectedPill
            
            self.pillTableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
