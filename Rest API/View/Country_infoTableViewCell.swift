//
//  Country_infoTableViewCell.swift
//  Rest API
//
//  Created by Seven on 14.08.2022.
//  Copyright © 2022 Niso. All rights reserved.
//

import UIKit

class Country_infoTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
