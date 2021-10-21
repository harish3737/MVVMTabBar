//
//  CategoriesCollectionViewCell.swift
//  NTCBase
//
//  Created by Sethuram Vijayakumar on 21/10/21.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoriesImageView: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.intialLoads()
    }

    
    
}


extension CategoriesCollectionViewCell {
    private func intialLoads(){
        self.categoriesImageView.setCorneredElevation(shadow: 10, corner: 20, color: .lightGray)
        setFont(to: categoriesLabel!, isTitle: true, size: 12, fontType: .meduim)
        self.categoriesLabel.textColor = .whiteColor
    }
}
