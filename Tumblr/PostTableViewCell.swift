//
//  PostTableViewCell.swift
//  Tumblr
//
//  Created by Carina Boo on 10/12/16.
//  Copyright © 2016 Carina Boo. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

  @IBOutlet weak var postImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
