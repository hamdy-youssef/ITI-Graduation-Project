//
//  DetailsVC.swift
//  ITI Graduation Project
//
//  Created by Hamdy Youssef on 03/09/2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet var detailsDesc: UILabel!
    @IBOutlet var detailsPrice: UILabel!
    @IBOutlet var detailsBrand: UILabel!
    @IBOutlet var detailsTitle: UILabel!
    @IBOutlet var detailsImagee: UIImageView!
    
    var titleName: String?
    var imagee: UIImage?
    var Price: String?
    var Brand: String?
    var Desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTitle.text = titleName
        detailsImagee.image = imagee
        detailsPrice.text = Price
        detailsBrand.text = Brand
        detailsDesc.text = Desc
    }
    



}
