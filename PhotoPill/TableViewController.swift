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
        let pill1 = Pill(name: "Alosetron", description: "Purpose: Manage and treat severe IBS-D \nImprint: LS 701 \nStrength: 1mg \nShape: Round \nColor: Blue \nForm: Tablet", imageName: "pill1")
        pillList.append(pill1)
        
        let pill2 = Pill(name: "Alprazolam", description: "Purpose:Manage panic and anxiety disorder \nImprint: 031 logo \nStrength: 1 mg \nShape: Round \nColor: Blue \nForm: Tablet", imageName: "pill2")
        pillList.append(pill2)
        
        let pill3 = Pill(name: "Amitriptyline", description: "Purpose: Tricyclic antidepressant - used to treat depression in adults \nImprint: 12 28 \nStrength: 75 mg \nShape: Round \nColor: Light Blue \nForm: Tablet", imageName: "pill3")
        pillList.append(pill3)
        
        let pill4 = Pill(name: "Amoxapine", description: "Purpose: Tricyclic antidepressant - used to treat depression in adults \nImprint: DAN 100 5715  logo \nStrength: 100 mg \nShape: Round \nColor: Blue \nForm: Tablet", imageName: "pill4")
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
