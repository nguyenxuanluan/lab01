//
//  TopSongTableViewCell.swift
//  ModuleLab
//
//  Created by LuanNX on 2/22/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit

class TopSongTableViewCell: UITableViewCell {
    @IBOutlet weak var subTitle: UILabel!

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageSongView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageSongView.layer.borderWidth = 1
        imageSongView.layer.masksToBounds = false
        imageSongView.layer.borderColor = UIColor.black.cgColor
        imageSongView.layer.cornerRadius = imageSongView.frame.height/2
        imageSongView.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUp(song: Song){
        self.imageSongView.downloadedFrom(link: song.imageName)
        self.title.text = song.name
        self.subTitle.text = song.artist
    }

}
