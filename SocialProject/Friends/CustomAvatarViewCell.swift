//
//  CustomAvatarViewCell.swift
//  SocialProject
//
//  Created by Irina Kuligina on 17.10.2021.
//

import UIKit

class CustomAvatarViewCell: UIView {

    lazy var imageView: UIImageView = {
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
