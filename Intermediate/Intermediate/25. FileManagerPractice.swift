//
//  FileManagerPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/04.
//

import SwiftUI

struct FileManagerPractice: View {
    
    @StateObject var viewModel = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    .cornerRadius(20)
                }

                HStack {
                    Button {
                        viewModel.saveImage()
                    } label: {
                        Text("Save to FileManager")
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical)
                            .background(.blue)
                            .cornerRadius(8)
                    }
                    
                    Button {
                        viewModel.deleteImage(name: "swift")
                    } label: {
                        Text("Delete FileManager")
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical)
                            .background(.red)
                            .cornerRadius(8)
                    }
                }
                
                Text(viewModel.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Spacer()

            }
            .navigationTitle("FileManagerPractice")
        }
    }
}

struct FileManagerPractice_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerPractice()
    }
}

// MARK: - FileManagerViewModel
class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var infoMessage: String = ""
    
    let imageName: String = "swift"
    let manager = LocalFileManager.instance
    
    init() {
        getImageFromAssetFolder()
        // getImageFromFileManager()
    }
    
    func getImageFromAssetFolder() {
        image = UIImage(named: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func deleteImage(name: String) {
        infoMessage = manager.deleteImage(name: name)
        manager.deleteFolder()
    }
}

// MARK: - LocalFileManager
class LocalFileManager {
    
    static let instance = LocalFileManager()
    let imageFolderName = "MyApp_images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard let data = image.jpegData(compressionQuality: 1.0),
              let path = getPathForImage(name: name) else {
            return "Error getting data..."
        }
        
        // let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        // let directory = FileManager.default.temporaryDirectory
            
        do {
            try data.write(to: path)
            return "Success saving"
        } catch {
            return error.localizedDescription
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
            print("Error getting path...")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager
                           .default
                           .urls(for: .cachesDirectory, in: .userDomainMask)
                           .first?
                           .appendingPathComponent(imageFolderName)
                           .appendingPathExtension("\(name).jpg") else {
            print("Error getting path...")
            return nil
        }
        
        return path
    }
    
    func deleteImage(name: String) -> String {
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
            return "Error getting path..."
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Successfully deleted"
        } catch {
            return error.localizedDescription
        }
    }
    
    func createFolderIfNeeded() {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(imageFolderName)
            .path else {
            return
        }
                
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path,
                                                        withIntermediateDirectories: true)
                print("Successfully created Folder")
            } catch {
                print(error)
            }
        }
    }
    
    func deleteFolder() {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(imageFolderName)
            .path else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Successfully deleted Folder")
        } catch {
            print(error)
        }
    }
}
