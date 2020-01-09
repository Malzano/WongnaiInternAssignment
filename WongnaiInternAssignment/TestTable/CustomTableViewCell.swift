//
//  CustomTableViewCell.swift
//  TestTable
//
//  Created by อธิคม ปิยะบงการ on 1/6/2563 BE.
//  Copyright © 2563 BE อธิคม ปิยะบงการ. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var like: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
