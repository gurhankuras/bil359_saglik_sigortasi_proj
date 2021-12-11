//
//  AffiliatedHospitalsView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/26/21.
//

import Foundation
import SwiftUI


//  TODO: move hardcoded texts to something else for localization etc.
struct HospitalsView : View {
    let companyId: Int
    @ObservedObject var hospitalVM: HospitalsViewModel
    @State var searchText: String = ""
    
    init(companyId: Int) {
        self.companyId = companyId
        self.hospitalVM = HospitalsViewModel(companyId: companyId)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(searchText: $searchText, placeholder: "Hastane Ara", actionText: "Ara") {
                hospitalVM.searchFor(name: searchText)
            }
            ScrollView {
                LazyVStack {
                    ForEach(hospitalVM.hospitals) { hospital in
                        HospitalView(hospital)
                            .onAppear {
                                if !hospitalVM.searched {
                                    hospitalVM.loadMore(currentItem: hospital)
                                }
                            }
                }
                .padding(.top)
                
            }
        
        }
            .navigationTitle("Hastaneler")
            .alert("Bulunamadı", isPresented: $hospitalVM.notFound) {
                Text("Tamam")
            }
            .overlay(
                NavigationLink(destination: {
                    AddHospitalPage()
                }, label: {
                    AddButton()
                })
                    .tint(.white)
                        ,
                    alignment: .bottomTrailing
               
            )
            
    }
}
}

struct TeklifAlButton: View {
    var body: some View {
            Text("Teklif Al")
                .padding(10)
                .lineLimit(1)
                .font(.callout)
                .foregroundColor(.white)
                .background(.primary)
                .frame(minWidth: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}



struct HospitalsView_Previews: PreviewProvider {
    static var previews: some View {
        HospitalsView(companyId: 45).preferredColorScheme(.dark).previewDevice("Iphone 11")
            
    }
}

struct HospitalView: View {
    let hospital: Hospital
    
    init(_ hospital: Hospital) {
        self.hospital = hospital
    }
    
    var body: some View {
        HStack() {
            Text(hospital.name)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 100)
            Spacer()
            VStack {
                Text("İl:").font(.subheadline)
                    .padding(.bottom, 2)
                Text(hospital.address.il).bold()
            }
            Spacer()
            VStack {
                Text("İlçe:").font(.subheadline)
                    .padding(.bottom, 2)
                Text(hospital.address.ilce).bold()
            }
            Spacer()
            NavigationLink(destination: TeklifAlView(), label: {
                TeklifAlButton()
                    .font(.callout)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
            })
            
        }
    
    }
}
