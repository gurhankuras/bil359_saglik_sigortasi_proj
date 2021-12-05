//
//  ContentView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CompaniesView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("Iphone 11")
    }
}
