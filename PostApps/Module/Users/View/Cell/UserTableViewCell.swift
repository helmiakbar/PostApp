//
//  UserTableViewCell.swift
//  PostApps
//
//  Created by tamu on 24/03/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellData(data: User?) {
        if let validData = data {
            usernameLbl.text = validData.name
        }
    }
    
}
