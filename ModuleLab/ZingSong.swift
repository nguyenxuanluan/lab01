//
//  ZingSong.swift
//  ModuleLab
//
//  Created by LuanNX on 2/25/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import Foundation
import SwiftyJSON
class ZingSong {
    var name = ""
    var author = ""
    var source = ""
    init(name:String,author:String,source:String) {
        self.name = name
        self.author = author
        self.source  = source
    }
    static func parseToZingSong(json: JSON) -> [ZingSong]{
        var zingSongArr = [ZingSong]()
     let docs = json["docs"].array!
        if docs.count == 5 {
        for i in 0...4{
            let songInfo = docs[i]
            let source = songInfo["source"]["128"].string!
            let name = songInfo["title"].string!
            let author = songInfo["artist"].string!
            zingSongArr.append(ZingSong(name: name, author: author, source: source))
        }
            return zingSongArr
        } else
        {return zingSongArr}
   
    }
}
