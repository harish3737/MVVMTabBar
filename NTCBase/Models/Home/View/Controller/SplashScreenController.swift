//
//  SplashScreenController.swift
//  NTCBase
//
//  Created by Sethuram Vijayakumar on 20/10/21.
//

import UIKit

class SplashScreenController: UIViewController {
    @IBOutlet weak var splashView: UIView!
    
    var viewModel : HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.intialLoads()
    }
    


}


extension SplashScreenController {
    
    
    private func intialLoads(){
        self.viewModel = HomeViewModel(vc: self)
        self.viewModel.initalLoads(viewController: self)
    }
    
    
}
