//
//  HomeTableViewCell.swift
//  PostApps
//
//  Created by tamu on 24/03/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userProfileNameLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postLbl: UILabel!
    @IBOutlet weak var imageLbl: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(data: Post?) {
        if let validData = data, let validUser = validData.user {
            userProfileNameLbl.text = validUser.name
            usernameLbl.text = "@\(validUser.username ?? "")"
            postLbl.text = validData.post
            print(validData)
            if validData.image == nil {
                imageLbl.isHidden = true
                imageHeight.constant = 0
            } else {
                imageLbl.isHidden = false
                imageHeight.constant = 134
                if let validImage = validData.image {
                    imageLbl.image = UIImage(data: validImage)
                }
            }
        }
    }
    
}
