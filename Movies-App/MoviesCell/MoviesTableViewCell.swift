//
//  MoviesTableViewCell.swift
//  Movies-App
//
//  Created by Erdal Keser on 12.11.2022.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
