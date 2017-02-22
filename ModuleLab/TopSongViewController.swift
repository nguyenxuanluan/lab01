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

class TopSongViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: Share!
    let dissposeBag = DisposeBag()
    let list = Variable<[Song]>([])
    
    @IBOutlet weak var buttonImage: UIButton!
    @IBOutlet weak var genre: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let number = delegate.getGenreNumber()
        let myGenre = delegate.getGenre()
       
        if let image = UIImage(named: "genre-\(number)") {
            buttonImage.setImage(image, for: .normal)
        }
        //genre.frame = CGRect(origin: CGPoint(x: 150, y: 20), size: genre.frame.size)
        genre.text = myGenre
        Alamofire.request("https://itunes.apple.com/us/rss/topsongs/limit=50/genre=\(number)/explicit=true/json").responseJSON{(response) in
            if let value = response.result.value{
                self.list.value = Song.parse(json: JSON( value ))
                
                self.list.asObservable().bindTo(self.tableView.rx.items(cellIdentifier: "cell", cellType: TopSongTableViewCell.self)){
                    
                    (row,song,cell) in
                    print("ABC")
                    cell.setUp(song: song)
                }.addDisposableTo(self.dissposeBag)
          
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
//        let lists = Observable<[Song]>.create( (observer) -> Disposable in
//        let request = Alamofire.request("https://itunes.apple.com/…/limit…/genre=1/explicit=true/json").responseJSON(completionHandler: {
//            (response) in
//            if let error = response.error{
//                observer.onNext()
//            }
//        })
//        )
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

