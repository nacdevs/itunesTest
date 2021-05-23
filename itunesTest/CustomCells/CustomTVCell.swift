//
//  CustomTVCell.swift
//  itunesTest
//
//  Created by Nestor on 19/05/2021.
//

import Foundation
import UIKit
import ApiManager
class CustomTVCell:UITableViewCell{
        public static let identifier = "customTVCell"
        
        let titleLabel:UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Album"
            label.font = .systemFont(ofSize: 24.0, weight:.medium)
            label.textColor = .darkGray
            return label
        }()
        
    
         let subtitleLabel:UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Author"
            label.font = .systemFont(ofSize: 15.0, weight:.medium)
            label.textColor = .gray
            return label
        }()
        
         let img:UIImageView = {
           let img = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.image = UIImage(named: "emptyAlbum")
            img.layer.cornerRadius = 10.0
            img.layer.masksToBounds = true
           return img
        }()
            
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        override func layoutSubviews() {
            contentView.addSubview(img)
            img.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            img.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
            img.heightAnchor.constraint(equalToConstant: 80).isActive = true
            img.widthAnchor.constraint(equalToConstant: 80).isActive = true
            
            contentView.addSubview(titleLabel)
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive=true
            titleLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 20).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5).isActive = true
            contentView.addSubview(subtitleLabel)
            subtitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive=true
            subtitleLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 20).isActive = true
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5).isActive = true
            
            self.imageView?.loadImage(fromURL: "https://i.imgur.com/Gb1pZUW.jpg")
            
            
            

        }
    
        override func awakeFromNib() {
            super.awakeFromNib()

        }
    
    func setData(album: Album){
        titleLabel.text = album.name
        self.img.image = nil
        self.img.loadImage(fromURL: album.art)
    }
    
    
}
