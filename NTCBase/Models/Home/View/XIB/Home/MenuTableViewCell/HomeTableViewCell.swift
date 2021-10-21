//
//  HomeTableViewCell.swift
//  NTCBase
//
//  Created by Sethuram Vijayakumar on 21/10/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var homeCollectionView : UICollectionView!
    
//    Delete once Api is given,Also delete the asset
    var categoriesArray = ["Category1","Category2","Category3","Category4","Category5","Category6","Category7","Category8"]
    var categoryImage = ["Categories","Categories","Categories","Categories","Categories","Categories","Categories","Categories"]

    override func awakeFromNib() {
        super.awakeFromNib()
        self.intialLoads()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension HomeTableViewCell {
    private func intialLoads(){
        self.registerCollectionView()
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
        
    }
    
    private func registerCollectionView(){
        self.homeCollectionView.register(UINib(nibName: XIB.CategoriesCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIB.CategoriesCollectionViewCell)
    }
}


extension HomeTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.CategoriesCollectionViewCell, for: indexPath) as! CategoriesCollectionViewCell
        cell.categoriesImageView.image = UIImage(named: self.categoryImage[indexPath.item])
        cell.categoriesLabel.text = self.categoriesArray[indexPath.item]
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.width/2)
           return CGSize(width:width , height: width)
//        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height) //<-- Manage height and width accordingly.
            }
    
    
    
}
