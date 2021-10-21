//
//  HomeVM.swift
//  NTCBase
//
//  Created by Sethuram Vijayakumar on 20/10/21.
//

import Foundation
import UIKit


class HomeViewModel {
    var vc : UIViewController!
    
    init(){}
    init(vc : UIViewController) {
        self.vc = vc
    }
    
}


extension HomeViewModel {
    func initalLoads(viewController:SplashScreenController){
        viewController.splashView.isUserInteractionEnabled = true
        viewController.splashView.addTap {
    
            let navigationController = UINavigationController(rootViewController: TabBarController())
                navigationController.navigationBar.isHidden = false
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
    }
    
    func registerTableViewCell(viewController:HomeScreenVC){
        viewController.homeTableView.register(UINib(nibName: XIB.HomeTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.HomeTableViewCell)
        viewController.homeTableView.delegate = viewController.self
        viewController.homeTableView.dataSource = viewController.self
        viewController.homeTableView.separatorStyle = .none
    }
    
}
