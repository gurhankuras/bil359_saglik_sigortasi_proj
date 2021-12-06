//
//  HospitalsViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation

// TODO: move all these "load when scrolled" logic into

class HospitalsViewModel: ObservableObject, RandomAccessCollection {
    // TODO: inject dependency
    typealias Element = Hospital
    
    var startIndex: Int { hospitals.startIndex }
    var endIndex: Int { hospitals.endIndex }
    
    subscript(position: Int) -> Hospital {
        return hospitals[position]
    }

    
    let companyId: String
    let hospitalService: HospitalServiceProtocol = HospitalService()
    @Published var hospitals = [Hospital]()
    @Published var hospitalsLoading: Bool = false
    @Published var error: ApiError?
    @Published var notFound: Bool = false
    
    var nextPageToLoad: Int = 1
    var currentlyLoading: Bool = false
    var allItemsLoaded = false
    
    init(companyId: String) {
        self.companyId = companyId
        loadMore()
    }
    
   
    enum InsertMode {
        case append, assign
    }
    
    func loadMore(currentItem: Hospital? = nil, name: String? = nil, insertMode: InsertMode = .append, warnNotFound: Bool = false) {
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        currentlyLoading = true
       
        hospitalService.fetchHospitals(for: companyId, page: nextPageToLoad, name: name, completed: {
            result in self.responseCallback(result: result, insertMode: insertMode, warnNotFound: warnNotFound) }
        )
    }
    
    
    private func responseCallback(result: Result<[Hospital], ApiError>, insertMode: InsertMode, warnNotFound: Bool) {
        switch result {
        case .failure(let error):
            DispatchQueue.main.async {
                self.handleError(error: error)
                self.currentlyLoading = false
            }
        case .success(let hospitals):
            DispatchQueue.main.async {
                if warnNotFound {
                    self.notFound = hospitals.isEmpty
                }
                switch insertMode {
                case .append:
                    self.hospitals.append(contentsOf: hospitals)
                case .assign:
                    self.hospitals = hospitals
                }
                self.nextPageToLoad += 1
                self.currentlyLoading = false
                self.allItemsLoaded = (hospitals.isEmpty)
            }
        }
        // result: Result<[Hospital], ApiError>
    }
    
    private func handleError(error: ApiError) {
        self.error = error
    }
    
    
    func shouldLoadMoreData(currentItem: Hospital? = nil) -> Bool {
        if allItemsLoaded { return false }
        if currentlyLoading { return false }
        
        guard let currentItem = currentItem else { return true }
        guard let lastItem = hospitals.last else { return true }
        
        return currentItem.id == lastItem.id
    }
    
   
    
    func searchFor(name: String) -> Void {
        DispatchQueue.main.async {
            self.error = nil
        }
        guard !name.isEmpty else {
             _searchFor()
             return
        }
        _searchFor(name: name)
    }
    
    private func _searchFor(name: String? = nil) {
        resetForNewRequest()
        loadMore(currentItem: nil, name: name, insertMode: .assign, warnNotFound: true)
    }
    
    private func resetForNewRequest() {
        self.nextPageToLoad = 1
        self.allItemsLoaded = false
    }
    
}
