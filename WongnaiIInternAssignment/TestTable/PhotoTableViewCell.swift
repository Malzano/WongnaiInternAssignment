//
//  PhotoTableViewCell.swift
//  PhotoTableViewCell
//
//  Created by อธิคม ปิยะบงการ on 3/3/2564 BE.
//  Copyright © 2564 BE อธิคม ปิยะบงการ. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    var photo: Photo! {
        didSet {
            updateUI()
        }
    }
    var img: UIImage?
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var like: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    
    func updateUI() {
        guard let urlI = URL(string: photo.image_url.first ?? "") else { return }
        try? img = UIImage(data: Data(contentsOf: urlI))
        pic.image = UIImage(data: img!.lowestQualityJPEGNSData)
        header.text = photo.name
        like.image = UIImage(named:"like")
        likeCount.text = String(photo.positive_votes_count)
        desc.text = photo.description
    }
}

extension UIImage {
    
    var highestQualityJPEGNSData: Data { return self.jpegData(compressionQuality: 1.0)! }
    var highQualityJPEGNSData: Data    { return self.jpegData(compressionQuality: 0.75)!}
    var mediumQualityJPEGNSData: Data  { return self.jpegData(compressionQuality: 0.5)! }
    var lowQualityJPEGNSData: Data     { return self.jpegData(compressionQuality: 0.25)!}
    var lowestQualityJPEGNSData: Data  { return self.jpegData(compressionQuality: 0.0)! }
    
}
