//
//  ViewController.swift
//  itunesTest
//
//  Created by Nestor on 19/05/2021.
//

import UIKit
import ApiManager
class ViewController: UIViewController {
    
    lazy var presenter = MainPresenter(presenterProtocol: self)
    var albums = [Album]()
    
    var coordinator: MainCoordinator?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTVCell.self, forCellReuseIdentifier: CustomTVCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        setConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        presenter.load50()
        self.title = "iTunes 50"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.separatorStyle = .none
        
    }
    
    func refresh(){
        tableView.reloadData()
    }
    
    func setConstraints(){
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    
}

//MARK: TableView delegates

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if albums.count == 0 {
            tableView.showActivityIndicator()
        } else {
            tableView.restore()
        }
        
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTVCell.identifier)! as UITableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellData = albums[indexPath.row]
        print("----\(cellData.name)")
        (cell as? CustomTVCell)?.setData(album: cellData)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        self.coordinator?.detail(album: album)
    }
    
    
}

//MARK: ViewController extension

extension ViewController:PresenterProtocol{
    func results<T>(data: [T]) {
        print("from delegate")
        dump(data)
        
        self.albums = data as! [Album]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func errorToUI() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "No internet", message: "Please check your internet connection and try again later", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: {
            })
        }
        
    }
    
}

//MARK: TableView extension

extension UITableView{
    func showActivityIndicator() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.center
        self.backgroundView = activityView
        self.separatorStyle = .none
        activityView.startAnimating()
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}


//MARK: ImageView extension

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    public func transition(toImage image: UIImage) {
        UIView.transition(with: self, duration: 0.1, options: [.transitionCrossDissolve], animations: {
            self.image = image
        }, completion: nil)
    }
    public func loadImage(fromURL url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }).resume()
            }
        }
    }
    
    
    
}

