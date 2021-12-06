//
//  ZASettings.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import Foundation
import UIKit

struct ZASettings {
    
    static var current: ZASettings = .init()
    
    var postFavorites : [PostsHomeModel.Posts.Response]? = []
}
