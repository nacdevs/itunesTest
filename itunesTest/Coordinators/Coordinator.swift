//
//  Coordinator.swift
//  itunesTest
//
//  Created by Nestor on 21/05/2021.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
