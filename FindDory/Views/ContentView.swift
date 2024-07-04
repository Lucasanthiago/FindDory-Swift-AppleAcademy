//
//  ContentView.swift
//  teste dory
//
//  Created by Lucas Santos on 29/02/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var selectedTab = 1 // Define o mapa como a aba inicial
    
    
    init() {
        configureTabBarAppearance()
        configureNavigationBarAppearance()
    }

    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(red: 16/255, green: 59/255, blue: 88/255, alpha: 1)
        
        // Define a aparência padrão e a aparência ao rolar para todas as versões que suportam
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }

    private func configureNavigationBarAppearance() {
        let titleColor = UIColor(red: 212 / 255.0, green: 233 / 255.0, blue: 247 / 255.0, alpha: 1)
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 8 / 255, green: 29 / 255, blue: 43 / 255, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: titleColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        
        // Aplica a aparência configurada para os estados padrão e compactos
        // e também para o estado de rolagem para iOS 15.0 ou superior
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            NavigationView {
                ContactsListView()
            }
            .tabItem {
                    Image("Contacts")
                    Text("Contacts")
            }
            .tag(0)
            
            NavigationView {
                MapView()
            }
            .tabItem {
                    Image("Map")
                    Text("Map")
            }
            .tag(1)
            
            NavigationView {
                ChatView()
            }
            .tabItem {
                    Image("Diary")
                    Text("Diary")

            }
            .tag(2)
        }
//        .presentationDetents(40)
        
    }
    
}




#Preview {
    ContentView()
}
