//
//  FriendsCollectionViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 12.10.2021.
//

import UIKit

class FriendsCollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "PostCollectionViewCell"
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        view.backgroundColor = Colors.palePurplePantone
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCollectionViewCell
        
        cell.setValues(item: posts[indexPath.item])
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PhotoViewerViewController") as! PhotoViewerViewController

        var photosArray: [UIImage] = []

        posts.forEach { (post) in
            photosArray.append(post.image)
        }

        //vc.getPhotosData(photos: photosArray, currentIndex: indexPath.item)

        self.navigationController?.pushViewController(vc, animated: true)
    }

}
