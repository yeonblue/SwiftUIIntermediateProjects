//
//  NSCachePractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/05.
//

import SwiftUI

struct NSCachePractice: View {
    
    @StateObject var viewModel = NSCacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = viewModel.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                }
                
                HStack {
                    Button {
                        viewModel.saveToCache()
                    } label: {
                        Text("Save to cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        viewModel.removeFormCache()
                    } label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                
                HStack {
                    Button {
                        viewModel.getFromCache()
                    } label: {
                        Text("Get to cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.green)
                            .cornerRadius(10)
                    }
                    
                    Button {
                       
                    } label: {
                        Text("Dummy Button")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.black)
                            .cornerRadius(10)
                    }
                }
                
                if let image = viewModel.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("NSCachePractice")
        }
    }
}

struct NSCachePractice_Previews: PreviewProvider {
    static var previews: some View {
        NSCachePractice()
    }
}

class NSCacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    
    let manager = CacheManager.instance
    let imageName = "swift"
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        manager.add(image: image, name: imageName)
    }
    
    func removeFormCache() {
        manager.remove(name: imageName)
    }
    
    func getFromCache() {
        cachedImage = manager.get(name: imageName)
    }
}

class CacheManager {
    
    static let instance = CacheManager()
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // 최대 저장 개수
        cache.totalCostLimit = 1024 * 1024 * 100 // 100MB, 캐시 최대 용량
        return cache
    }() // String은 불가능
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Added to cache")
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("Removed to cache")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}
