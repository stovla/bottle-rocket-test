//
//  BRCollectionViewCell.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 02/01/2020.
//  Copyright © 2020 Vlastimir. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    private let lineVerticalSpacing: CGFloat = 6
    var restaurant: Restaurant? {
        didSet {
            populateViews()
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.textColor = .white
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.textColor = .white
        return label
    }()
    
    let shadowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "cellGradientBackground")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        setupViews()
    }
    
    private func setupViews() {
        
        addSubview(imageView)
        addSubview(shadowImage)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        shadowImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        shadowImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        shadowImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        shadowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        shadowImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -lineVerticalSpacing).isActive = true
        categoryLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        categoryLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: lineVerticalSpacing * 2).isActive = true
        
        nameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -lineVerticalSpacing).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor).isActive = true
    }
    
    private func populateViews() {
        guard let restaurant = restaurant else { return }
        nameLabel.text = restaurant.name
        categoryLabel.text = restaurant.category
    }
    
    func downloadImageFrom(urlString: String) {
        if let data = CacheManager.cachedDataFrom(urlString: urlString) {
            imageView.image = UIImage(data: data)
            return
        }
        
        DispatchQueue.global().async {
            NetworkManager.load(with: urlString) { result in
                print(urlString)
                switch result {
                    case .success(let data):
                        CacheManager.cacheData(data: data, from: urlString)
                        do {
                            let image = UIImage(data: data)
                            DispatchQueue.main.async { [weak self] in
                                self?.imageView.image = image
                                print("Success for image")
                            }
                    }
                    
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
