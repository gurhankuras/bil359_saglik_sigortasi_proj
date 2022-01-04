//
//  Dependencies.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/16/21.
//

import Foundation

class Dependencies: ObservableObject {
    let networkService: NetworkServiceProtocol = NetworkService()
}
