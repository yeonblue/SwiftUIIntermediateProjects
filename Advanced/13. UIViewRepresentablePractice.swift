//
//  UIViewRepresentablePractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/13.
//

import SwiftUI

// UIKit의 UIView를 SwiftUI서 사용하기 위함 -> UIViewRepresentable

struct UIViewRepresentablePractice: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            
            HStack {
                Text("SwiftUI: ")
                    .frame(width: 70)
                TextField("Type here..", text: $text)
                    .frame(height: 55)
                    .background(.green)
            }

            HStack {
                Text("UIKit: ")
                    .frame(width: 70)
                UITextFieldViewRepresentable(text: $text)
                    .updatePlaceHolder("New Placeholder")
                    .frame(height: 55)
                    .background(.yellow)
            }
        }
    }
}

struct UIViewRepresentablePractice_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentablePractice()
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    var placeholderColor: UIColor
    
    init(text: Binding<String>,
         placeholder: String = "Default Placeholder",
         placeholderColor: UIColor = .gray) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    func makeUIView(context: Context) -> UITextField { // 정확한 타입을 알고있으므로 지정
        let textField = getTextField()
        textField.delegate = context.coordinator
        
        return textField
    }
    
    // swiftUI에서 uikit으로 데이터를 보낼 떄 사용
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func updatePlaceHolder(_ text: String) -> UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    private func getTextField() -> UITextField {
        let textfield = UITextField(frame: .zero)
        
        let placeHolder = NSAttributedString(string: placeholder,
                                             attributes: [.foregroundColor : placeholderColor])
        
        textfield.attributedPlaceholder = placeHolder
        return textfield
    }
    
    // UIView와 swiftUI interface가 통신할 수 있게 하는 함수
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}
