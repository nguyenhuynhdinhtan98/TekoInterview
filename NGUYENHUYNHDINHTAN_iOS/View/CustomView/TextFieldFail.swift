//
//  TextFieldFail..swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 06/01/2023.
//

import Foundation
import SwiftUI

struct TextFieldFail: View {
    let error: String
    var body: some View {
        return Text(error).frame(maxWidth: .infinity, alignment: .leading)
    }
}
 
