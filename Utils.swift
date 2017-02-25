//
//  Utils.swift
//  ModuleLab
//
//  Created by LuanNX on 2/22/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class Utils{
    
    static func getUrlArr(genreNumberArr: [Int]) ->[String]{
        
        var genreArr = [String]()
        for i in genreNumberArr{
            let url = "https://itunes.apple.com/us/rss/topsongs/limit=50/genre=\(i)/explicit=true/json"
            genreArr.append(url)
        }
        return genreArr
    }
    static func parseToGenre(json: JSON) -> String{
        let feed = json["feed"]
        let title = feed["title"]
        let label = title["label"].string
        let gen = label?.replacingOccurrences(of: "iTunes Store: Top Songs in ", with: "")
        return gen!
        
    }
    static func parseLinkSource(json: JSON,index: Int) ->String {
        let docs = json["docs"].array!
        let songInfo = docs[index]
        let link = songInfo["source"]["128"].string!
        return link
    }
    static func getName(mySongName:String)->String{
    
        let arr = mySongName.components(separatedBy: " - ")
        let subArr =  arr[0].components(separatedBy: " (")
        return subArr[0]
    }
    static func getApiLinkFromSong(name:String,author:String) -> String{
        var string = "http://api.mp3.zing.vn/api/mobile/search/song?requestdata="
        var st = "{\"q\":\"\(name) \(author)\", \"sort\":\"hot\", \"start\":\"0\", \"length\":\"5\"}"
        
        st = st.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        string += st
        print(string)
        return string
        
    }
   
    
}
extension String{
   
}
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                
                self.image = image
            }
            
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
