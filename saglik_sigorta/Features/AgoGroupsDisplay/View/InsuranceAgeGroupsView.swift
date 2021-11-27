//
//  InsuranceAgeGroupsView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation
import SwiftUI

struct InsuranceAgeGroupView : View {
    @StateObject var ageVM : AgeBasedOfferViewModel = AgeBasedOfferViewModel()
    var body: some View {
        VStack {
            SearchBar(searchText: $ageVM.searchText, placeholder: "Yaşınızı giriniz", actionText: "Ara") {
                ageVM.validateAgeInput()
            }
            
            Text("250 ₺")
                .font(.system(size: 60))
                .fontWeight(.semibold)
            
            Spacer()
        }
        .navigationTitle("Şirket Teklifi")
        .alert(ageVM.errorMessage, isPresented: $ageVM.showErrorMessage) {
            Button("Ok") {
                
            }
        }
        
      
    }
}



struct InsuranceAgeGroupView_Previews: PreviewProvider {
    static var previews: some View {
        InsuranceAgeGroupView().previewDevice("Iphone 11")
            .preferredColorScheme(.dark)
    }
}
