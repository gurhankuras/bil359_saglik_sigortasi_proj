//
//  InsuranceCompaniesViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation


// TODO: extract all common functions
class CompaniesViewModel : ObservableObject {

    // TODO: Conform to a protocol and inject dependency
    let companyService: CompaniesService = CompaniesService()
    let pg = Pagination<Company>()
    var searched: Bool = false
    
    @Published var companies = [Company]()
    @Published var companiesLoading: Bool = false
    @Published var error: ApiError?
    @Published var notFound: Bool = false
    
    init() {
        loadMore()
    }
    
    func loadMore(currentItem: Company? = nil,
                  name: String? = nil,
                  insertMode: InsertMode = .append,
                  warnNotFound: Bool = false) {
        if !pg.shouldLoadMoreData(currentItem: currentItem, items: companies) {
            return
        }
        pg.currentlyLoading = true
       
        companyService.fetchCompanies(page: pg.nextPageToLoad, name: name) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handleError(error: error)
                    self.pg.failed()
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
                    self.pg.successfullyLoaded(itemsExhausted: fetchedCompanies.isEmpty)
                }
            }
        }
    }
    
    private func handleError(error: ApiError) {
        self.error = error
    }
    
    func searchFor(name: String) -> Void {
        DispatchQueue.main.async {
            self.error = nil
        }
        self.searched = true
        guard !name.isEmpty else {
             _searchFor()
             self.searched = false
             return
        }
        _searchFor(name: name)
    }
    
    private func _searchFor(name: String? = nil) {
        pg.resetForNewRequest()
        loadMore(currentItem: nil, name: name, insertMode: .assign, warnNotFound: true)
    }
}



extension CompaniesViewModel: RandomAccessCollection {
    typealias Element = Company
    
    var startIndex: Int { companies.startIndex }
    var endIndex: Int { companies.endIndex }
    
    subscript(position: Int) -> Company {
        return companies[position]
    }
}
