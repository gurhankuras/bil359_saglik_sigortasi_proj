//
//  Pagination.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/6/21.
//

import Foundation


class Pagination<T: Identifiable> {
    
    var nextPageToLoad: Int = 1
    var currentlyLoading: Bool = false
    var allItemsLoaded = false
    
    func resetForNewRequest() {
        self.nextPageToLoad = 1
        self.allItemsLoaded = false
    }
    
    func successfullyLoaded(itemsExhausted: Bool) {
        nextPageToLoad += 1
        currentlyLoading = false
        allItemsLoaded = itemsExhausted
    }
    
    func failed() {
        currentlyLoading = false
    }
    
    func shouldLoadMoreData(currentItem: T? = nil, items: [T]) -> Bool {
        if allItemsLoaded { return false }
        if currentlyLoading { return false }
        
        guard let currentItem = currentItem else { return true }
        guard let lastItem = items.last else { return true }
        
        return currentItem.id == lastItem.id
    }
}
