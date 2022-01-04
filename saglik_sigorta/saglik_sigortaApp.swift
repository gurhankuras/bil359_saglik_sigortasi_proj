//
//  saglik_sigortaApp.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import SwiftUI
import Resolver

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) ->
      Bool {
        print("Your code here")
        return true
    }
}

@main
struct saglik_sigortaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let companiesViewModel = CompaniesViewModel(companyService: CompaniesService(networkService: NetworkService()))
    let dependencies = Dependencies()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(companiesViewModel)
                .environmentObject(dependencies)
        }
    }
}
