//
//  CustomTextField.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 06/01/2023.
//

import Foundation
import SwiftUI

struct CustomTextField : View {
    
    @State var hint: String = ""
    
    @State var text: String = "" {
        didSet {
            isValid = !text.isEmpty && text.count <= characterLimit
            errorMessage = isValid ? "" : typeErrorMessage.rawValue
        }
    }
    
    var characterLimit: Int = 0
    var typeErrorMessage: ErrorMessage
    
    @State private var errorMessage: String = ""
    @Binding var isValid: Bool
    
    var body: some View {
        return VStack {
            TextField(hint, text: $text, onEditingChanged: { isChange in
                text = text
            })
                .onChange(of: text, perform: { newValue in
                    self.text = newValue
                })
            TextFieldFail(error: errorMessage)
        }
    }
}
