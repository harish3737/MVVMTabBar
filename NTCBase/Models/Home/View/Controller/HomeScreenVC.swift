//
//  HomeScreenVC.swift
//  NTCBase
//
//  Created by Sethuram Vijayakumar on 20/10/21.
//

import UIKit

class HomeScreenVC: UIViewController {
    
    var homeScreenArray = ["","","",""]
    
    @IBOutlet weak var homeTableView:UITableView!
    
    var vm : HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialLoads()
    }


}



extension HomeScreenVC {
    
    private func intialLoads(){
        self.vm = HomeViewModel.init(vc: self)
        self.vm.registerTableViewCell(viewController: self)
 }

    
}


extension HomeScreenVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeScreenArray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.HomeTableViewCell, for: indexPath) as! HomeTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 5
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return nil
        }
        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 5
    }

    
    
}
