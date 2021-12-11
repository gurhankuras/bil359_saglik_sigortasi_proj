//
//  AddButton.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        Image(systemName: "plus")
            .resizable()
            .frame(width: 35, height: 35, alignment: .trailing)
            .padding()
            .background(.blue)
            .clipShape(Circle())
            .offset(x: -10)
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
