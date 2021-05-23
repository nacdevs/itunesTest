//
//  MainCoordinator.swift
//  itunesTest
//
//  Created by Nestor on 21/05/2021.
//

import Foundation
import UIKit
import ApiManager
class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewController()
        vc.coordinator = self
        vc.title = "itunes50"
        navigationController.pushViewController(vc, animated: false)
    }
    
    func detail(album:Album) {
        let vc = DetailVC(album: album)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
