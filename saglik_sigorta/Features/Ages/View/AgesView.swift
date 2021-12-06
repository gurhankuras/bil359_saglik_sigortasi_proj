//
//  InsuranceAgeGroupsView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation
import SwiftUI

struct AgesView : View {
    let emptyStr = ""
    @StateObject var ageVM : AgeBasedOfferViewModel = AgeBasedOfferViewModel()
    var body: some View {
        VStack {
            SearchBar(searchText: $ageVM.searchText, placeholder: "Yaşınızı giriniz", actionText: "Ara") {
                guard let age = ageVM.validateAgeInput() else {
                    return
                }
                ageVM.getOffer(forAge: age)
            }
            Spacer()
            if ageVM.offer != nil {
                VStack {
                    Text("Yas: -")
                    // Text("Yaş: \(ageVM.offer!.age)")
                        .font(.largeTitle)
                        .padding()
                    Text("AXA Sigorta Mevcut Fiyat:")
                        .font(.system(size: 25))
                    Text("Yaş Aralığı \(ageVM.offer!.ageStart)-")
                    Text("\(String(format: "%.1f", ageVM.offer!.amount))₺")
                        .font(.system(size: 60))
                        .fontWeight(.semibold)
                    
                    
                }
            }
            Spacer()
            Spacer()
        }
        .navigationTitle("Şirket Teklifi")
        .alert(ageVM.errorMessage, isPresented: $ageVM.showErrorMessage) {
            Button("Ok") {
                
            }
        }
    }
}



struct AgesView_Previews: PreviewProvider {
    static var previews: some View {
        AgesView().previewDevice("Iphone 11")
            .preferredColorScheme(.dark)
    }
}
