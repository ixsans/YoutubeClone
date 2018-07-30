//
//  File.swift
//  YoutubeApp
//
//  Created by Ikhsan on 26/7/18.
//  Copyright © 2018 Yanmii. All rights reserved.
//

import UIKit

class Video: NSObject {
    var title: String?
    var thumbnailImageName: String?
    var numOfView: NSNumber?
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
