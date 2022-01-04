//
//  CompaniesService.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation
import Combine
import Resolver

enum DenemeError : Error {
    case error
}
protocol CompanyServiceProtocol {
    
    //func fetchCompanies(page: Int?, name: String?, completed: @escaping ApiResultCallback<[Company], ApiError>)
}

/*: CompanyServiceProtocol*/
struct CompaniesService: CompanyServiceProtocol{
    /*
    func fetchCompanies(page: Int, name: String?) async throws -> [Company] {
        var urlString = ApiUrls.url(path: ApiUrls.companies)
        urlString += "?page=\(page)"
        if name != nil {
            urlString += "&name=\(name!.replacingOccurrences(of: " ", with: "%20"))"
        }
        
        print(urlString)
        
        guard let url = URL(string: urlString) else { throw ApiError.invalidUrl }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ApiError.error }
        guard let companies = try? JSONDecoder().decode([Company].self, from: data) else {
            throw ApiError.badResponseData
        }
        
        return companies
    }
     */
    
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        print("CompaniesService initiliazed!")
    }
    
    func getCompanies(page: Int, name: String?) -> AnyPublisher<[Company], Error> {
        var urlString = ApiUrls.url(path: ApiUrls.companies)
        urlString += "?page=\(page)"
        if name != nil {
            urlString += "&name=\(name!.replacingOccurrences(of: " ", with: "%20"))"
        }
        
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            return Just([])
                .tryMap { _ in
                    throw ApiError.invalidUrl
                }
                .eraseToAnyPublisher()
        }
        return networkService.publisher(for: url, responseType: [Company].self, decoder: .init())
            .eraseToAnyPublisher()
    }
    
    
    // TODO: add pagination
         func fetchCompanies(page: Int, name: String?, completed: @escaping ApiResultCallback<[Company], ApiError>) {
             
             var urlString = ApiUrls.url(path: ApiUrls.companies)
             urlString += "?page=\(page)"
             if name != nil {
                 urlString += "&name=\(name!.replacingOccurrences(of: " ", with: "%20"))"
             }
             
             print(urlString)
             
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
                     let companies = try JSONDecoder().decode([Company].self, from: data)
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
