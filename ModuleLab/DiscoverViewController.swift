//
//  DiscoverViewController.swift
//  ModuleLab
//
//  Created by LuanNX on 2/19/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxCocoa
import RxSwift
import SlideMenuControllerSwift
class DiscoverViewController: UIViewController,UICollectionViewDelegate {
    @IBOutlet weak var slideButton: UIBarButtonItem!
    let genreNumberArr = [2,3,4,5,6,7,9,10,11,12,14,15,16,17,18,19,20,21,22,24,34,50,51]
    var arr = [String]()
    var selectedGenreNumber:Int!
    var selectedGenre:String!
    let disposeBag = DisposeBag()
    let lists = Variable<[String]>([])
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        getData()
        
        

        // Do any additional setup after loading the view.
    }
    @IBAction func touchSlideButton(_ sender: Any) {
        print("ABC")
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedRow = collectionView.indexPathsForSelectedItems![0].row
        let subView = segue.destination as! TopSongViewController
        subView.delegate = self
        selectedGenreNumber = genreNumberArr[selectedRow]
        let cell = collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems![0]) as! CollectionViewCell
        selectedGenre=cell.label.text
        print(selectedGenre)
        print(selectedGenreNumber)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        self.lists.value = Utils.getUrlArr(genreNumberArr: genreNumberArr)
        self.lists.asObservable().bindTo(self.collectionView.rx.items(cellIdentifier: "collectionCell", cellType: CollectionViewCell.self)){
            (item,url,cell) in
            cell.number = self.genreNumberArr[item]
            cell.loadImage(url: url)
        }.addDisposableTo(self.disposeBag)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
