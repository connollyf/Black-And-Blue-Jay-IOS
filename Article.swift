//
//  File.swift
//  The Black And Blue Jay
//
//  Created by joseph Connolly on 7/17/17.
//  Copyright © 2017 joseph Connolly. All rights reserved.
//

import Foundation
import UIKit
import CoreData

private let blackAndBlueJayLogo = "https://secure.gravatar.com/blavatar/dc9092bf8576c0415e0e404828a11155?s=96&#038;d=https%3A%2F%2Fs2.wp.com%2Fi%2Fbuttonw-com.pngv"

class Article: NSObject {
    var title = String()
    var content = String()
    var articleDescription = String()
    var datePublished: Date? = Date()
    var articleUrl = URL(string: "https://theblackandbluejay.com/")
    var imageUrl: URL?
    var safeImageUrl: URL {
        get {
            return imageUrl ?? URL(string: blackAndBlueJayLogo)!
        }
    }
    var image: UIImage?
 
}
