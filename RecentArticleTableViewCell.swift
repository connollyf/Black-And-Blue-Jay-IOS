//
//  RecentArticleTableViewCell.swift
//  The Black And Blue Jay
//
//  Created by joseph Connolly on 7/19/17.
//  Copyright © 2017 joseph Connolly. All rights reserved.
//

import UIKit

class RecentArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
