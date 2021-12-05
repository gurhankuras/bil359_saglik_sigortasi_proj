//
//  CompaniesService.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation


protocol CompanyServiceProtocol {
    
    //func fetchCompanies(page: Int?, name: String?, completed: @escaping ApiResultCallback<[InsuranceCompany], ApiError>)
}

/*: CompanyServiceProtocol*/
struct CompaniesService{
    func fetchCompanies(page: Int, name: String?) async throws -> [InsuranceCompany] {
        var urlString = ApiUrls.url(path: ApiUrls.companies)
        urlString += "?page=\(page)"
        if name != nil {
            urlString += "&name=\(name!.replacingOccurrences(of: " ", with: "%20"))"
        }
        
        print(urlString)
        
        guard let url = URL(string: urlString) else { throw ApiError.invalidUrl }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ApiError.error }
        guard let companies = try? JSONDecoder().decode([InsuranceCompany].self, from: data) else {
            throw ApiError.badResponseData
        }
        
        return companies
    }
    
    // TODO: add pagination
         func fetchCompanies(page: Int, name: String?, completed: @escaping ApiResultCallback<[InsuranceCompany], ApiError>) {
             
             var urlString = ApiUrls.url(path: ApiUrls.companies)
             urlString += "?page=\(page)"
             if name != nil {
                 urlString += "&name=\(name!.replacingOccurrences(of: " ", with: "%20"))"
             }
             
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




/*
 
 
 
 //
 //  CompaniesService.swift
 //  saglik_sigorta
 //
 //  Created by Gürhan Kuraş on 11/27/21.
 //

 import Foundation


 protocol CompanyServiceProtocol {
     
     func fetchCompanies(page: Int?, name: String?, completed: @escaping ApiResultCallback<[InsuranceCompany], ApiError>)
 }

 struct CompaniesService: CompanyServiceProtocol {
     
     // TODO: add pagination
     func fetchCompanies(page: Int?, name: String?, completed: @escaping ApiResultCallback<[InsuranceCompany], ApiError>) {
         
         var urlString = ApiUrls.url(path: ApiUrls.companies)
         if name != nil {
             urlString += "?name=\(name!.replacingOccurrences(of: " ", with: "%20"))"
         }
         if page != nil {
             urlString += "?page=\(page!)"
         }
         
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


 
 */
