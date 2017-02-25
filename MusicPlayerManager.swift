//
//  MusicPlayerManager.swift
//  ModuleLab
//
//  Created by LuanNX on 2/25/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation
class MusicManage : NSObject{
    static var shareInstance = MusicManage()
    var player: AVPlayer?
}
