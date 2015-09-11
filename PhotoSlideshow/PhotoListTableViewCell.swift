//
//  photoListTableViewCell.swift
//  PhotoSlideshow
//
//  Created by Masanori.KANEKO on 2015/09/11.
//  Copyright (c) 2015年 Masanori.KANEKO. All rights reserved.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {
    @IBOutlet var labelOrder: UILabel!
    @IBOutlet var imageViewPhoto: UIImageView!
    @IBOutlet var labelMemo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
