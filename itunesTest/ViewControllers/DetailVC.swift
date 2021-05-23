//
//  DetailVC.swift
//  itunesTest
//
//  Created by Nestor on 21/05/2021.
//

import Foundation
import UIKit
import ApiManager
public class DetailVC:UIViewController{
    var album:Album
    var coordinator: MainCoordinator?
    
    let mainView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let img:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .blue
        img.image = UIImage(named: "emptyAlbum")
        img.layer.cornerRadius = 10.0
        img.layer.masksToBounds = true
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Album"
        label.font = .systemFont(ofSize: 25.0, weight:.medium)
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    
    let subtitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Author"
        label.font = .systemFont(ofSize: 15.0, weight:.medium)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    let genre:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "genre"
        label.font = .systemFont(ofSize: 14.0, weight:.medium)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    let date:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "date"
        label.font = .systemFont(ofSize: 14.0, weight:.medium)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    let copyright:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Copyright"
        label.font = .systemFont(ofSize: 12.0, weight:.medium)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    let btn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Open in iTunes", for: .normal)
        btn.setTitleColor(.link, for: .normal)
        btn.addTarget(self, action: #selector(didTapItunes(sender:)), for: .touchUpInside)
        return btn
    }()
    
    init(album:Album){
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never
        setViews()
        setConstraints()
        setData()
    }
    
    func setViews(){
        view.addSubview(mainView)
        mainView.addSubview(img)
        mainView.addSubview(titleLabel)
        mainView.addSubview(subtitleLabel)
        mainView.addSubview(genre)
        mainView.addSubview(date)
        mainView.addSubview(copyright)
        mainView.addSubview(btn)
    }
    
    
    func setConstraints(){
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        
        img.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        img.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 25).isActive = true
        img.heightAnchor.constraint(equalToConstant: 270).isActive = true
        img.widthAnchor.constraint(equalToConstant: 270).isActive = true
        img.loadImage(fromURL: album.art)
        
        
        titleLabel.topAnchor.constraint(equalTo: img.bottomAnchor,constant: 25).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: mainView.widthAnchor , constant: -50).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 5).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        genre.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5).isActive = true
        genre.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        genre.heightAnchor.constraint(equalToConstant: 15).isActive = true
        genre.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        date.topAnchor.constraint(equalTo: genre.bottomAnchor, constant: 5).isActive = true
        date.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        date.heightAnchor.constraint(equalToConstant: 15).isActive = true
        date.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        copyright.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 5).isActive = true
        copyright.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        copyright.heightAnchor.constraint(equalToConstant: 50).isActive = true
        copyright.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        btn.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        btn.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20).isActive = true
        btn.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20).isActive = true
        btn.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20).isActive = true
    }
    
    
    func setData(){
        titleLabel.text = album.name
        subtitleLabel.text = album.artist
        genre.text = album.genre[0].name
        date.text = album.date
        copyright.text = album.copyright
        
    }
    
    @objc func didTapItunes(sender: Any) {
        if let url = URL(string: album.url){
            UIApplication.shared.open(url)
        }
    }
}
