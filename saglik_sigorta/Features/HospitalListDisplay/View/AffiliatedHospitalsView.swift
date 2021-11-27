//
//  AffiliatedHospitalsView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation
import SwiftUI



struct AffiliatedHospitalsView : View {
    @StateObject var hospitalVM: HospitalsViewModel = HospitalsViewModel()
    @State var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(searchText: $searchText, placeholder: "Hastane Ara", actionText: "Ara") {
                
            }
            ScrollView {
                LazyVStack {
                    ForEach(hospitalVM.hospitals) { hospital in
                        HStack(spacing: 25) {
                            Text("Details")
                            Spacer()
                            Text(hospital.name)
                            Button(action: { },
                                   label: {
                                Text("Teklif Al")
                                    .padding(10)
                                    .font(.callout)
                                    .foregroundColor(.white)
                                    .background(.primary)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            })
                        }
                        .font(.callout)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
                
            }
            // Spacer()
            
        }.navigationTitle("Hastaneler")
    }
}



struct AffiliatedHospitalsView_Previews: PreviewProvider {
    static var previews: some View {
        AffiliatedHospitalsView().preferredColorScheme(.dark).previewDevice("Iphone 11")
            
    }
}
