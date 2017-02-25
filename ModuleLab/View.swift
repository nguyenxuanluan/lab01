//
//  View.swift
//  ModuleLab
//
//  Created by LuanNX on 2/25/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit

class View: UIView {
    @IBOutlet var contentView: UIView!

    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "View", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
            
            // custom initialization logic
    }
    func setUpImageView(imageName : String){
        imageView.image = UIImage(named: imageName)
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
