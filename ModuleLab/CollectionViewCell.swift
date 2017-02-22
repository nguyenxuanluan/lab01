//
//  CollectionViewCell.swift
//  ModuleLab
//
//  Created by LuanNX on 2/19/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class CollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var imageView: UIImageView!
    var number:Int!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    
    func setUp(genre:String, imageName:String){
        imageView.image = UIImage(named: imageName)
        label.text = genre
    }
    func loadImage(url:String){
        indicator.startAnimating()
        Alamofire.request(url).responseJSON(){
            (response) in
            if let result = response.result.value {
                let temp = Utils.parseToGenre(json: JSON(result))
                self.label.text = temp
                self.imageView.image = UIImage(named: "genre-\(self.number!)")
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                
            }
        }
    }
  
}
