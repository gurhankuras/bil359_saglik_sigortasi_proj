//
//  LazyView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import SwiftUI

struct LazyView<T: View>: View {
    init(view: @escaping () -> T) {
        self.view = view
        // print("LazyView initiliazed!")
    }
    var view: () -> T
    var body: some View {
        self.view()
    }
}
