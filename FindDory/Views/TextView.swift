//
//  TextView.swift
//  teste dory
//
//  Created by Bennett Oliveira on 05/03/24.
//

import SwiftUI

struct TextView: View {
    let chatMessage: ChatMessage
    var body: some View {
        ZStack{
            Color(vinte)
                .ignoresSafeArea()
            VStack {
                Text(chatMessage.title)
                    .font(.title.bold())
                    .foregroundColor(noventa)
                    .frame(maxWidth: .infinity,  alignment: .topLeading)
                    .padding([.top, .leading, .trailing], 30)
                
                Text(chatMessage.text)
                    .font(.title3)
                    .foregroundColor(noventa)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding([.leading, .bottom, .trailing], 30)
                    
            }
        }
    }
}

#Preview {
    TextView(chatMessage: ChatMessage(title: "AAA", text: "aaaaa", date: .now))
}
