//
//  LocalFileManager.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/08.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() {}
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName) else { return }
        
        createFolderIfNeeded(folderName: folderName)
        
        do {
            try data.write(to: url)
        } catch {
            print("Error save image: \(imageName), \(folderName)")
            print(error.localizedDescription)
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path)  else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                print("Error creating Directory at: \(folderName)")
                print(error.localizedDescription)
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager
                        .default
                        .urls(for: .cachesDirectory, in: .userDomainMask)
                        .first else {
                return nil
            }
        
        return url.appendingPathExtension(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        
        return folderURL.appendingPathExtension(imageName + ".png")
    }
}
