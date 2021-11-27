//
//  CompaniesService.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation


struct CompaniesService {
    typealias CompaniesResultCallback = (Result<[InsuranceCompany], CompaniesServiceError>) -> Void
    
    
    // TODO: add pagination
    func fetchCompanies(page: Int, completed: @escaping CompaniesResultCallback) {
        
        let urlString = ApiUrls.url(path: ApiUrls.companies)
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                completed(.failure(.error))
                return;
            }
        
            do {
                let companies = try JSONDecoder().decode([InsuranceCompany].self, from: data)
                completed(.success(companies))
            }
            catch {
                completed(.failure(.badResponseData))
                print(error)
            }
        }
        
        task.resume()
    }
}

enum CompaniesServiceError: String, Error {
    case serverSide = "Server Error"
    case invalidUrl = "Invalid URL"
    case badResponseData = "Corrupt Data"
    // TODO: Later come and fix this based on bad request, response codes etc.
    case error = "Error"
}
