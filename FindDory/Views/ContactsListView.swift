//
//  ContactsListView.swift
//  teste dory
//
//  Created by Lucas Santos on 29/02/24.
//

import SwiftUI

// Definição do modelo de dados para os contatos
struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let number: String
    let imageName: String // Assuma que estas imagens existem no seu Asset Catalog
    var isFavorite: Bool // Indica se o contato é favorito
}

// Lista de contatos
struct ContactsListView: View {
    @State private var contacts = [
        Contact(name: "Jenny", number: "(22) 2998-4372", imageName: "Jenny", isFavorite: true),
        Contact(name: "Marlin", number: "(21) 3535-2474", imageName: "Marlin", isFavorite: true),
        Contact(name: "Charlie", number: "(24) 3661-8921", imageName: "Charlie", isFavorite: true),
        Contact(name: "Nemo", number: "(21) 3445-1220", imageName: "Nemo", isFavorite: false),
        Contact(name: "Mr. Ray", number: "(24) 3415-6744", imageName: "Mr. Ray", isFavorite: false),
        Contact(name: "Crush", number: "(21) 3319-6479", imageName: "Crush", isFavorite: false),
        Contact(name: "Hank", number: "(22) 3113-7146", imageName: "Hank", isFavorite: false),
        Contact(name: "Destiny", number: "(22) 3643-8857", imageName: "Destiny", isFavorite: false),
        Contact(name: "Bailey", number: "(22) 2807-8433", imageName: "Bailey", isFavorite: false),
        Contact(name: "Becky", number: "(22) 3992-3162", imageName: "Becky", isFavorite: false),
        Contact(name: "Otters", number: "(21) 3456-2624", imageName: "Otters", isFavorite: false),
        Contact(name: "Rudder", number: "(21) 3947-3265", imageName: "Rudder", isFavorite: false),
        Contact(name: "Gerald", number: "(24) 2731-2249", imageName: "Gerald", isFavorite: false),
        Contact(name: "Fluke", number: "(22) 3446-1302", imageName: "Fluke", isFavorite: false)
    ]
    @State private var searchText = ""
    @State private var showingFavoritesOnly = false
    
    var filteredContacts: [Contact] {
        contacts.filter { contact in
            (!showingFavoritesOnly || contact.isFavorite) &&
            (searchText.isEmpty || contact.name.localizedCaseInsensitiveContains(searchText))
        }
        .sorted { // Adicionando ordenação
            if $0.isFavorite && !$1.isFavorite {
                return true // Favoritos sempre vêm primeiro
            } else if !$0.isFavorite && $1.isFavorite {
                return false // Não favoritos sempre vêm depois
            } else {
                return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
        }
    }

    var body: some View {
        VStack {
            List {
                Toggle(isOn: $showingFavoritesOnly) {
                    Text("Favorites")
                        .font(.title3)
                        .foregroundStyle(oitenta)
                    
                }
                .listRowBackground(dez)
                
                ForEach(filteredContacts) { contact in
                    HStack {
                        Image(contact.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(trinta, lineWidth: 2))
                        
                        VStack(alignment: .leading) {
                            Text(contact.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(contact.number)
                                .font(.subheadline)
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        if contact.isFavorite {
                            Image(systemName: "star.circle.fill")
                                .foregroundColor(noventa)
                            
                            
                        }
                    }
                    
                    .listRowBackground(dez) // Define a cor de fundo para cada linha da List
                    .onTapGesture {
                        // Implementar a lógica para favoritar/desfavoritar
                        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
                            contacts[index].isFavorite.toggle()
                        }
                    }
                }
                
            }
            .background(dez) // Define a cor de fundo para cada linha da List
            .navigationBarTitle("Contacts")
            .searchable(text: $searchText, prompt: "Search contacts")
            .listStyle(PlainListStyle())
        }
        .background(dez) // Define a cor de fundo para cada linha da List

    }
}

// Adicione esta extensão para garantir que os favoritos apareçam no topo da lista
extension Array where Element == Contact {
    mutating func sortFavorites() {
        self.sort { ($0.isFavorite && !$1.isFavorite) }
    }
}

#Preview {
    ContactsListView()
}
