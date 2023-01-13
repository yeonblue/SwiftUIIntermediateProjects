//
//  UIViewControllerRepresentablePractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/13.
//

import SwiftUI

struct UIViewControllerRepresentablePractice: View {
    
    @State private var showScreen: Bool = false
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            
            Text("Hi")
            
            Button {
                showScreen.toggle()
            } label: {
                Text("Click Here")
            }
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .sheet(isPresented: $showScreen) {
            UIImagePickerControllerRepresentable(image: $image, showScreen: $showScreen)
        }
    }
}

struct UIViewControllerRepresentablePractice_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerRepresentablePractice()
    }
}

struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    let labelText: String
    
    func makeUIViewController(context: Context) -> MyFirstViewController {
        let vc = MyFirstViewController()
        vc.labelText = labelText
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MyFirstViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> () {
        
    }
}

class MyFirstViewController: UIViewController {
    
    var labelText: String = "Init String"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let label = UILabel()
        label.text = labelText
        label.textColor = .green
        
        view.addSubview(label)
        label.frame = view.frame
    }
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    // SwiftUI -> UIKit
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // UIKit -> SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var showScreen: Bool
        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            showScreen = false
            print("select canceled")
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newImage = info[.originalImage] as? UIImage else { return }
            image = newImage
            showScreen = false
        }
    }
}
