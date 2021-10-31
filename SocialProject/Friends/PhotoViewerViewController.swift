//
//  PhotoViewerViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 27.10.2021.
//

import UIKit

class PhotoViewerViewController: UIViewController {

        var photos: [UIImage] = []
        var currentIndex: Int = 0 {
            didSet {
                if self.currentIndex < 0 {
                    self.currentIndex = 0
                } else if currentIndex >= photos.count {
                    self.currentIndex = photos.count - 1
                }
            }
        }
        
        var currentImage: UIImage? {
            get {
                guard photos.count > 0 else { return nil }
                
                return photos[currentIndex]
            }
        }
        
        lazy var currentImageView: UIImageView = {
            var imageView = UIImageView(frame: self.view.frame)
            imageView.image = UIImage(named: "profile1")

            imageView.backgroundColor = .black
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true

            return imageView
        }()
        

        override func viewDidLoad() {
            super.viewDidLoad()

            setupView()
            
            setCurrentImageView()
            
            view.addSubview(currentImageView)

        }
        
        private func setupView() {
            view.backgroundColor = .black
        }
        
        private func setCurrentImageView() {
            guard photos.count > 0,
                  currentIndex > -1,
                  photos.count > currentIndex else { return }
            
            currentImageView.image = currentImage
        }
        
        func getPhotosData(photos: [UIImage], currentIndex: Int) {
            self.photos = photos
            self.currentIndex = currentIndex
        }
        


        
       
    }

