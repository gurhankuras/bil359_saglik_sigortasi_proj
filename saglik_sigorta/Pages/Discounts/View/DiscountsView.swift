//
//  DiscountsView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 1/3/22.
//

import SwiftUI

struct DiscountsView: View {
    @StateObject var vm: DiscountViewModel = DiscountViewModel(networkService: NetworkService())
   
    var body: some View {
        VStack {
            
            List {
                ForEach(vm.offers) { companyOffer in
                    CompanyOfferAccordion(showDiscountPercent: true, companyOffer: companyOffer)
                }.onDelete { indexSet in
                    vm.deleteDiscounts(offsets: indexSet)
                    // vm.deleteCompany(offsets: indexSet)
                }
                
            }
        }
        .navigationTitle("İndirimler")
        /*
        .alert(ageVM.errorMessage, isPresented: $ageVM.showErrorMessage) {
            Button("Ok") {
                
            }
        }
         */
        .overlay(
            NavigationLink(destination: {
                AddDiscount()
            }, label: {
                AddButton()
            })
                .tint(.white),
                alignment: .bottomTrailing
           
        )
        .onAppear {
            vm.loadDiscounts()
        }
    }
}
