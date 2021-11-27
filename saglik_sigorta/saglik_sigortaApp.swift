//
//  saglik_sigortaApp.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import SwiftUI

@main
struct saglik_sigortaApp: App {
    let companiesViewModel = InsuranceCompaniesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(companiesViewModel)
        }
        
    }
}
