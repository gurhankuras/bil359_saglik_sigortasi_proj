//
//  InsuranceCompaniesViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation


// TODO: extract all common functions
class CompaniesViewModel : ObservableObject, RandomAccessCollection {
    
    
    typealias Element = InsuranceCompany
    
    var startIndex: Int { companies.startIndex }
    var endIndex: Int { companies.endIndex }
    
    var nextPageToLoad: Int = 1
    var currentlyLoading: Bool = false
    var allItemsLoaded = false
    
    subscript(position: Int) -> InsuranceCompany {
        return companies[position]
    }
    
    @Published var companies = [InsuranceCompany]()
    @Published var companiesLoading: Bool = false
    @Published var error: ApiError?
    @Published var notFound: Bool = false
    
    init() {
        loadMore()
    }
    
    enum InsertMode {
        case append, assign
    }
    
    func loadMore(currentItem: InsuranceCompany? = nil, name: String? = nil, insertMode: InsertMode = .append, warnNotFound: Bool = false) {
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        currentlyLoading = true
       
        companyService.fetchCompanies(page: nextPageToLoad, name: name) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                }
            case .success(let fetchedCompanies):
                DispatchQueue.main.async {
                    if warnNotFound {
                        self.notFound = fetchedCompanies.isEmpty
                    }
                    
                    switch insertMode {
                    case .append:
                        self.companies.append(contentsOf: fetchedCompanies)
                    case .assign:
                        self.companies = fetchedCompanies
                    }
                    
                    self.nextPageToLoad += 1
                    self.currentlyLoading = false
                    self.allItemsLoaded = (fetchedCompanies.isEmpty)
                }
            }
        }
    }
        

     
    
    func shouldLoadMoreData(currentItem: InsuranceCompany? = nil) -> Bool {
        if allItemsLoaded {
            return false
        }
        if currentlyLoading {
            return false
        }
        guard let currentItem = currentItem else {
            return true
        }
        
        guard let lastItem = companies.last else {
            return true
        }
        
        return currentItem.id == lastItem.id
    }
    
    
    // TODO: Conform to a protocol and inject dependency
    let companyService: CompaniesService = CompaniesService()
    
   

    func fetchCompanies(page: Int, name: String? = nil) async -> Void {
        if (currentlyLoading) {
            return
        }
        
        DispatchQueue.main.async {
            self.companiesLoading = true
        }
        do {
            let companies = try await companyService.fetchCompanies(page: page, name: name)
            DispatchQueue.main.async {
                self.companies = companies
            }
        }
        catch {
            DispatchQueue.main.async {
                print(error)
                self.error = (error as? ApiError) ?? .error
            }
        }
        DispatchQueue.main.async {
            self.companiesLoading = false
        }
    }
    
    func searchCompany(_ name: String) -> Void {
        DispatchQueue.main.async {
            self.error = nil
        }
        guard !name.isEmpty else {
            // showSearchResults = false
            // return;
             self.nextPageToLoad = 1
             self.allItemsLoaded = false
             loadMore(currentItem: nil, name: nil, insertMode: .assign, warnNotFound: true)
            return
        }
         self.nextPageToLoad = 1
        self.allItemsLoaded = false
         loadMore(currentItem: nil, name: name, insertMode: .assign, warnNotFound: true)
        
    }
}

