//
//  searchCell.swift
//  ITI Graduation Project
//
//  Created by Hamdy Youssef on 03/09/2023.
//

import UIKit

class searchCell: UITableViewCell {

    @IBOutlet var searchName: UILabel!
    @IBOutlet var searchImage: UIImageView!
    
    @IBOutlet var searchAddToFav: UIButton!
    @IBOutlet var searchPrice: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addToFavBtn(_ sender: UIButton) {
        
    }
}
