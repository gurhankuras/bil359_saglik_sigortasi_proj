//
//  InsuranceCompaniesViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation


class InsuranceCompaniesViewModel : ObservableObject {
    // let companies : [InsuranceCompany] = InsuranceCompany.companies
    @Published var remoteCompanies: [InsuranceCompany] = []
    @Published var companiesLoading: Bool = false
    @Published var error: CompaniesServiceError?
    
    
    // TODO: Conform to a protocol and inject dependency
    let companyService: CompaniesService = CompaniesService()
    
    init() {
        print("VIEWMODEL INIT")
        fetchCompanies()
    }
    
    func fetchCompanies() {
        companiesLoading = true
        companyService.fetchCompanies(page: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let companies):
                DispatchQueue.main.async {
                    self.remoteCompanies = companies
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                }
            }
            DispatchQueue.main.async {
                self.companiesLoading = false
            }
        }
    }
    
    // TODO: add pagination
    /*
    func fetchCompanies() {
        let urlString = ApiUrls.url(path: ApiUrls.companies)
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return;
            }
            
            do {
                let companies = try JSONDecoder().decode([InsuranceCompany].self, from: data)
                
                DispatchQueue.main.async {
                    self.remoteCompanies = companies
                }
            }
            catch {
                print(error)
                print("\n\n\n\n")
            }
        }
        
        task.resume()
    }
     */
    
    
}
