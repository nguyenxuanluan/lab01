//
//  Song.swift
//  ModuleLab
//
//  Created by LuanNX on 2/19/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import Foundation
import SwiftyJSON

class Song {
    var name = ""
    var artist = ""
    var imageName = ""
    init(name: String, artist: String, imageName : String) {
        self.name = name
        self.artist = artist
        self.imageName = imageName
    }
    
    class func parse(json: JSON) -> [Song] {
        var songs = [Song]()
        let feed = json["feed"]
        let entries = feed["entry"].array!
        for entry in entries {
            let name = entry["title"]["label"].string!
            let artist = entry["im:artist"]["label"].string!
            let images = entry["im:image"].array!
            let image1 = images[0]["label"].string!
            let song = Song(name: name, artist: artist,imageName: image1)
            songs.append(song)
        }
        return songs
    }
}
