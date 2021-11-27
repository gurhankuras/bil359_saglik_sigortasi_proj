//
//  ApiUrls.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation


enum ApiUrls: String {
    static let baseUrl = "http://localhost:3000"
    
    static func url(path: ApiUrls) -> String {
        return "\(ApiUrls.baseUrl)\(path.rawValue)"
    }
    
    case companies = "/api/companies"
}
