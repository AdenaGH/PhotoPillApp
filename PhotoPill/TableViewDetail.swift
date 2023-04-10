//
//  TableViewDetail.swift
//  PhotoPill
//
//  Created by Adena Ninvalle on 4/10/23.
//

import Foundation
import UIKit

class TableViewDetail : UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet var name: UITextField!
    
   
    

    var selectedPill : Pill!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = selectedPill.name;
        image.image = UIImage(named: selectedPill.imageName)
        
    }
    
}
