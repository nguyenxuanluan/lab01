//
//  ViewController.swift
//  ModuleLab
//
//  Created by LuanNX on 2/18/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import AlamofireImage
import SwiftyJSON
import AVKit
import AVFoundation
class TopSongViewController: UIViewController,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: Share!
    let dissposeBag = DisposeBag()
    let list = Variable<[Song]>([])
    var player : AVPlayer!
    var numberOfgenre: Int!
    var selectedImageName : String!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var buttonImage: UIButton!
    @IBOutlet weak var genre: UILabel!
    var selectedSong:String!
    var selectedAuthor:String!
    override func viewDidLoad() {
        tableView.delegate = self
        super.viewDidLoad()
        let number = delegate.getGenreNumber()
        let myGenre = delegate.getGenre()
        imageView.image = UIImage(named: "genre-\(number)")
        numberOfgenre = number
        //genre.frame = CGRect(origin: CGPoint(x: 150, y: 20), size: genre.frame.size)
        genre.text = myGenre
        Alamofire.request("https://itunes.apple.com/us/rss/topsongs/limit=50/genre=\(number)/explicit=true/json").responseJSON{(response) in
            if let value = response.result.value{
                self.list.value = Song.parse(json: JSON( value ))
                
                self.list.asObservable().bindTo(self.tableView.rx.items(cellIdentifier: "cell", cellType: TopSongTableViewCell.self)){
                    
                    (row,song,cell) in
                    cell.setUp(song: song)
                }.addDisposableTo(self.dissposeBag)
          
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        selectedSong = Utils.getName(mySongName: (cell?.contentView.viewWithTag(101) as! UILabel).text!)
        
        selectedAuthor = (cell?.contentView.viewWithTag(102) as! UILabel).text
        let myLink = Utils.getApiLinkFromSong(name: selectedSong, author: selectedAuthor)
        getZingSong(apiLink: myLink, compareString: selectedSong + " " + selectedAuthor)
        print(selectedSong + " " + selectedAuthor)
        
        
        //playSongWithTitle(title: selectedSong)
       
        
    }
    func getZingSong(apiLink: String,compareString : String){
        var zingSongArr = [ZingSong]()
        Alamofire.request(apiLink).responseJSON{
            (response) in
            if let value = response.result.value {
                zingSongArr = ZingSong.parseToZingSong(json: JSON(value))
                var  max = 0.0
                var index = 0
                if !zingSongArr.isEmpty{
                    for i in  0...zingSongArr.count-1{
                        let string = zingSongArr[i].name + " " + zingSongArr[i].author
                        let score = compareString.score(string)
                        if score > max {
                            max = score
                            index = i
                        }
                    }
                   let  playingSong = zingSongArr[index]
                   MusicManage.shareInstance.player =  AVPlayer(url: URL(string: playingSong.source)!)
                    MusicManage.shareInstance.player?.play()
                    self.addSubView(imageName: "genre-\(self.numberOfgenre)", songName: playingSong.name, author: playingSong.author)
                    print("genre-\(self.numberOfgenre!)")
                    print("Run")
                    
                    
                } else {
                    print("Can't play")
                }
                
            }
        }
        
    }
    func addSubView(imageName: String,songName:String,author:String){
        let subView = View(frame: CGRect(origin: CGPoint(x:0,y:self.view.frame.height-50), size: CGSize(width: self.view.frame.width, height: 50)))
        subView.setUpImageView(imageName: imageName)
        subView.songName.text = songName
        subView.author.text = author
        subView.progress.setProgress(0, animated: false)
        view.addSubview(subView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

