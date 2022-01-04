//
//  HospitalService.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/29/21.
//



import Foundation

typealias ApiResultCallback<R, E: Error> = (Result<R, E>) -> Void

protocol HospitalServiceProtocol {
    func fetchHospitals(for companyId: Int, page: Int, name: String?, completed: @escaping ApiResultCallback<[Hospital], ApiError>)
}

struct HospitalService: HospitalServiceProtocol {
    func fetchHospitals(for companyId: Int, page: Int, name: String?, completed: @escaping ApiResultCallback<[Hospital], ApiError>) {
        
        
        // TODO: move URL string formatting logic into somewhere else
        var urlString = ApiUrls.getAffiliatedHospitals(for: companyId)
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
                let hospitals = try JSONDecoder().decode([Hospital].self, from: data)
                completed(.success(hospitals))
            }
            catch {
                completed(.failure(.badResponseData))
                print(error)
            }
        }
        
        task.resume()
    }
    
    
    
}


