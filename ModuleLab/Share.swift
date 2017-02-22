//
//  Share.swift
//  ModuleLab
//
//  Created by LuanNX on 2/22/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import Foundation
protocol Share: class {
    func getGenreNumber() -> Int
    func getGenre()->String
}
extension DiscoverViewController:Share{
     func getGenre() -> String {
        print(self.selectedGenre)
        return self.selectedGenre
    }

    func getGenreNumber() -> Int {
        print(self.selectedGenreNumber)
        return self.selectedGenreNumber
    }

    
}
