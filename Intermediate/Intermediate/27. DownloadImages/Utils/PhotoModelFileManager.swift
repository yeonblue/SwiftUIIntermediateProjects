//
//  PhotoModelFileManager.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/05.
//

import SwiftUI

class PhotoModelFileManager { // 실제로 디바이스에 저장, 자주 사용되는 유저의 프로파일 이미지 같은 것을 저장하면 좋을 듯
    
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("downloaded_photo directory created")
            } catch {
                print(error)
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathExtension(folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else { return nil }
        
        return folder.appendingPathExtension(key + ".png")
    }
    
    func add(key: String, image: UIImage) {
        guard let data = image.pngData(),
              let url = getImagePath(key: key) else {
            return
        }
        
        do {
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func get(key: String) -> UIImage? {
        guard let url = getImagePath(key: key),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
}
