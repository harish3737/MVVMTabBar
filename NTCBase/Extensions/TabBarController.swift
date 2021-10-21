//
//  TabBarController.swift
//  NTCBase
//
//  Created by Sethuram Vijayakumar on 20/10/21.
//

import Foundation
import UIKit

class TabBarController:  UITabBarController, UITabBarControllerDelegate{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listTabBarController()
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 100
        tabFrame.origin.y = self.view.frame.size.height - 100
        self.tabBar.frame = tabFrame
        
    }
    
    
    
    func listTabBarController() {
        
        // Set up the home View Controller
        let homeViewController =  UIStoryboard.init(name: storyboardName.Home.rawValue, bundle: nil).instantiateViewController(withIdentifier: VCID.HomeScreenVC.rawValue)
        homeViewController.tabBarItem.title = Constant.home.localize
        homeViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x12)], for: .normal)
        homeViewController.navigationController?.isNavigationBarHidden = false
        homeViewController.tabBarItem.image = UIImage(named: Constant.home)
        homeViewController.tabBarItem.selectedImage = UIImage(named: Constant.home)
        let homeViewNavigation = UINavigationController(rootViewController: homeViewController)
        
        // Set up the stats View Controller
        let statsViewController =  UIStoryboard.init(name: storyboardName.Home.rawValue, bundle: nil).instantiateViewController(withIdentifier: VCID.StatsController.rawValue)
        statsViewController.tabBarItem.title = Constant.stats.localize
        statsViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x12)], for: .normal)
        statsViewController.tabBarItem.image = UIImage(named: Constant.stats)
        statsViewController.tabBarItem.selectedImage = UIImage(named: Constant.stats)
        let statsNavigation = UINavigationController(rootViewController: statsViewController)
        
        
        // Set up the Search View Controller
        let searchViewController =  UIStoryboard.init(name: storyboardName.Home.rawValue, bundle: nil).instantiateViewController(withIdentifier: VCID.SearchController.rawValue)
        searchViewController.tabBarItem.title = Constant.search.localize
        searchViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x12)], for: .normal)
        searchViewController.tabBarItem.image = UIImage(named: Constant.search)
        searchViewController.tabBarItem.selectedImage = UIImage(named: Constant.search)
        let searchNavigation = UINavigationController(rootViewController: searchViewController)
        
        // Set up the Profile View Controller
        let profileViewController =  UIStoryboard.init(name: storyboardName.Home.rawValue, bundle: nil).instantiateViewController(withIdentifier: VCID.ProfileController.rawValue)
        profileViewController.tabBarItem.title = Constant.profile.localize
        profileViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x12)], for: .normal)
        profileViewController.tabBarItem.image = UIImage(named: Constant.profile)
        profileViewController.tabBarItem.selectedImage = UIImage(named: Constant.profile)
        let profileNavigation = UINavigationController(rootViewController: profileViewController)
        
        
        // Set up the More View Controller
        let moreViewController =  UIStoryboard.init(name: storyboardName.Home.rawValue, bundle: nil).instantiateViewController(withIdentifier: VCID.MoreScreenController.rawValue)
        moreViewController.tabBarItem.title = Constant.more.localize
        moreViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x12)], for: .normal)
        moreViewController.tabBarItem.image = UIImage(named: Constant.more)
        moreViewController.tabBarItem.selectedImage = UIImage(named: Constant.more)
        let moreNavigation = UINavigationController(rootViewController: moreViewController)
        moreNavigation.navigationItem.hidesBackButton = true
        
        
//        let tabBarController = UITabBarController()
        self.viewControllers = [homeViewNavigation, statsNavigation, searchNavigation, profileNavigation, moreNavigation]
        self.tabBar.tintColor = .primaryColor
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.borderColor = .lightGray
        self.tabBar.borderLineWidth = 0.5
        self.tabBar.backgroundColor = .white
     
        //tabBarController.tabBar.delegate = self
        //var tabFrame = tabBarController.tabBar.frame
        //tabFrame.size.height = 60
        //tabFrame.origin.y = self.view.frame.size.height
       // tabBarController.tabBar.frame = tabFrame
        
       
        
       
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.viewControllers?.firstIndex(of: viewController)
           let subView = tabBar.subviews[index!+1].subviews.first as! UIImageView
           self.performSpringAnimation(imgView: subView)
    }
    func performSpringAnimation(imgView: UIImageView) {

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {

            imgView.transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)

            //reducing the size
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                imgView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (flag) in
            }
        }) { (flag) in

        }
    }
}



