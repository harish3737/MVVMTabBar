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
    
            let navigationController = UINavigationController(rootViewController: TabBarController().listTabBarController())
//                navigationController.navigationBar.isHidden = true
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
    }
    
}
