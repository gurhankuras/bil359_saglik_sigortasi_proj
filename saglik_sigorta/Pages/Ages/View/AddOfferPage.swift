//
//  AddOfferPage.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct AddOfferPage: View {
    @StateObject var vm: AddOfferViewModel = AddOfferViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            LabeledTextField(label: "Şirket Adı", text: $vm.companyName)
            LabeledTextField(label: "Başlangıç Yaşı", text: $vm.ageStart)
            LabeledTextField(label: "Bitiş Yaşı", text: $vm.ageEnd)
            LabeledTextField(label: "Fiyat", text: $vm.price)
            Spacer()
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    
                    Text("İptal")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            .red.opacity(0.8)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                .tint(.white)
                
                Button {
                    vm.addOffer()
                    // dismiss()
                } label: {
                    
                    Text("Ekle")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            .green.opacity(0.8)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                .tint(.white)
                

            }
            
        }
        .padding()
        .padding(.horizontal)
        
        .alert(vm.message ?? "", isPresented: $vm.showMessage) {
            Button {
                if !vm.hasError {
                    dismiss()                    
                }
                vm.hasError = false
            } label: {
                Text("Tamam")
            }

        }
    }
}




struct AddOfferPage_Previews: PreviewProvider {
    static var previews: some View {
        AddOfferPage()
            .preferredColorScheme(.dark)
    }
}

struct LabeledTextField: View {
    let label: String
    @Binding var text: String
    let placeholder: String = ""
    
    var body: some View {
        VStack {
            Text(label)
                .font(.title3.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
