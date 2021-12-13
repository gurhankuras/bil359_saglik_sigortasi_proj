//
//  AddHospitalPage.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct AddHospitalPage: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var vm: AddHospitalViewModel = AddHospitalViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hastane Adı")
                .font(.title2)
                .bold()
            SearchBox(searchText: $vm.hospitalName, placeholder: "")
                .padding(.bottom, 30)
            Text("Anlaşmalı Şirketler")
                .font(.title2)
                .bold()
            if vm.companiesLoading {
                Spacer()
            }
            else {
                ScrollView {
                    VStack {
                        ForEach(vm.companies) { company in
                            HStack {
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing)
                                Text(company.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                CheckBoxView(id: company.id, vm: vm)
                            }
                            .contentShape(Rectangle())
                            .padding(10)
                            /*
                            .onTapGesture {
                                isSelected.toggle()
                            }
                             */
                            Divider()
                        }
                    }
                }
            }
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
                    
                }
                .tint(.white)
                
                Button {
                    vm.addHospital()
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
                }
                .tint(.white)

            }
        

        }
        .padding()
        .alert(vm.infoMessage ?? "", isPresented: $vm.showAlert) {
            Button {
                dismiss()
            } label: {
                Text("Tamam")
            }

        }
        
    }
}

struct CheckBoxView: View {
    let id: Int
    @ObservedObject var vm: AddHospitalViewModel
    @State var checked: Bool = false

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            
            .onTapGesture {
                if self.checked {
                    vm.uncheck(id: id)
                }
                else {
                    vm.check(id: id)
                }
                self.checked.toggle()
            }
             
    }
}

struct AddHospitalPage_Previews: PreviewProvider {
    static var previews: some View {
        AddHospitalPage()
            .preferredColorScheme(.dark)
    }
}
