//
//  Informer.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 1/4/22.
//

import Foundation
import Combine


class MessageDisplayer: ObservableObject {
    var message: String?
    /*{
        didSet {
           if  newValue
        }
    }
     */
    @Published var show: Bool = false
    
    var cancellables = Set<AnyCancellable>()

    init() {
        $show.sink {[weak self] show in
            print(show)
            if !show {
                self?.message = nil
            }
        }
        .store(in: &cancellables)
    }
    
    func on(message: String) {
        self.message = message
        self.show = true
    }
    
    func off() {
        print(#function)

        show = false
    }
    
    
    
}
