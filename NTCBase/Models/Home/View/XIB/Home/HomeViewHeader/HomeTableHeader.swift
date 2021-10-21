//
//  HomeTableHeader.swift
//  NTCBase
//
//  Created by Sethuram Vijayakumar on 21/10/21.
//

import UIKit

class HomeTableHeader: UIView {

    @IBOutlet weak var titleLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


extension HomeTableHeader {
    private func intialLoads(){
        setFont(to: titleLabel as! UILabel,fontType: .meduim)
    }
}
