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
        // print("GET ")
        return "\(ApiUrls.baseUrl)\(path.rawValue)"
    }
    
    case companies = "/api/companies"
    
    static func getAffiliatedHospitals(for companyId: Int) -> String {
        let formattedURL = "\(baseUrl)\(ApiUrls.companies.rawValue)/\(companyId)/hospitals"
        // print(formattedURL)
        return formattedURL
    }
    
    static func offer(companyId: Int) -> String {
        let formattedURL = "\(baseUrl)/api/companies/\(companyId)/offer"
        // print(formattedURL)
        return formattedURL
    }
    
    static func deleteCompany(id: Int) -> String {
        let formattedUrl = "\(baseUrl)/api/companies/\(id)"
        return formattedUrl
    }
    
    static func deleteHospital(id: Int) -> String {
        let formattedUrl = "\(baseUrl)/api/hospitals/\(id)"
        return formattedUrl
    }
}
