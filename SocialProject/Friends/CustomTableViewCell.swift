//
//  CustomTableViewCell.swift
//  SocialProject
//
//  Created by Irina Kuligina on 20.10.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarView: CustomAvatarView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Colors.palePurplePantone
        
    }
    
    func setValues(item: CellModel) {
        avatarView.setImage(item.image)
        nameLabel.text = item.name
    }


}
