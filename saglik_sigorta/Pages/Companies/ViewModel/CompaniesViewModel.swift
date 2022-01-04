//
//  InsuranceCompaniesViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation
import Combine
import Resolver

struct DemoMessage: Codable {
    let message: String
}

// TODO: extract all common functions
class CompaniesViewModel : ObservableObject {

    // TODO: Conform to a protocol and inject dependency
    private let companyService: CompaniesService

    let pg = Pagination<Company>()
    var searched: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    @Published var companies = [Company]()
    @Published var companiesLoading: Bool = false
    @Published var error: ApiError?
    @Published var notFound: Bool = false
    
    init(companyService: CompaniesService) {
        self.companyService = companyService
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
         /*
        companyService.getCompanies(page: pg.nextPageToLoad, name: name)
            .sink {[weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleError(error: error as? ApiError ?? .error)
                    self?.pg.failed()
                case .finished:
                    print("COMPLETED");
                    
                }
            } receiveValue: {[weak self] fetchedCompanies in
                if warnNotFound {
                    self?.notFound = fetchedCompanies.isEmpty
                }
                
                switch insertMode {
                case .append:
                    self?.companies.append(contentsOf: fetchedCompanies)
                case .assign:
                    self?.companies = fetchedCompanies
                }
                self?.pg.successfullyLoaded(itemsExhausted: fetchedCompanies.isEmpty)
            }
          */

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
    
    
    func deleteCompany(offsets: IndexSet) {
        guard let willDeletedIndex = offsets.first else {
            return;
        }
        
        let willDeletedCompany = companies[willDeletedIndex]
        print(willDeletedCompany)
        
        guard let request = makeDenemeRequest(id: willDeletedCompany.id) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput(output:))
            .decode(type: DemoMessage.self, decoder: JSONDecoder())
            .sink { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("finished")
                    self?.companies.remove(atOffsets: offsets)
                case .failure(let error):
                    print("HATA OLDU")
                }
                print("COMPLETION: \(completion)")
    
            } receiveValue: {[weak self] msg in
                print(msg.message)
            }
            .store(in: &cancellables)
        
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        let (data, response) = output;
        guard let response = response as? HTTPURLResponse,
              response.isGoodStatusCode else {
                  throw URLError(.badServerResponse)
              }
        return data
    }
    
    
    private func makeDenemeRequest(id: Int) -> URLRequest? {
        guard let url = URL(string: ApiUrls.deleteCompany(id: id)) else {
            print("Error: cannot create URL")
            return nil
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        return request
    }
}


/*
extension CompaniesViewModel: RandomAccessCollection {
    typealias Element = Company
    
    var startIndex: Int { companies.startIndex }
    var endIndex: Int { companies.endIndex }
    
    subscript(position: Int) -> Company {
        return companies[position]
    }
}
*/
