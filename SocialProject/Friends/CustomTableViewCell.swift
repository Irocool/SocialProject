//
//  CustomTableViewCell.swift
//  SocialProject
//
//  Created by Irina Kuligina on 17.10.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
        
    @IBOutlet weak var avatarView: CustomAvatarViewCell!
    @IBOutlet weak var nameLabel: UILabel!
  
    func setValues(item: CellModel) {
        avatarView.setImage(item.image)
        nameLabel.text = item.name
    }
}
