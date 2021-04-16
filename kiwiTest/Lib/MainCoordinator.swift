//
//  MainCoordinator.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 16.4.21..
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = FlightsTVC.instantiate()
        vc.mainCoordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func buy(flight: String?) {
        let vc = WebVC()
        vc.urlString = flight
        navigationController.pushViewController(vc, animated: true)
    }
}

