//
//  favoritesCell.swift
//  ITI Graduation Project
//
//  Created by Hamdy Youssef on 03/09/2023.
//

import UIKit

class favoritesCell: UITableViewCell {

    @IBOutlet var favPrice: UILabel!
    @IBOutlet var favName: UILabel!
    @IBOutlet var favImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
