//
//  PhotoModelCacheManager.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/05.
//

import SwiftUI

class PhotoModelCacheManager { // 앱에 저장될 필요가 없는 인스타그램 팔로우 이미지 같은 경우 적합, 메모리에 저장됨
    
    static let instance = PhotoModelCacheManager()
    private init() {}
    
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    func add(key: String, image: UIImage) {
        photoCache.setObject(image, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }
}
